# source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting; end

for brew in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
    if test -x $brew
        $brew shellenv | source
        break
    end
end

switch (uname)
    case Darwin
        set -gx PNPM_HOME $HOME/Library/pnpm
        fish_add_path -g /opt/homebrew/opt/rustup/bin
    case '*'
        set -gx PNPM_HOME $HOME/.local/share/pnpm
end

set -gx BUN_INSTALL $HOME/.bun

fish_add_path -g \
    $HOME/.local/bin \
    $PNPM_HOME/bin \
    $BUN_INSTALL/bin

function fish_prompt
    set -l last_status $status

    set_color cyan
    printf '%s' (prompt_pwd)
    set_color yellow
    printf '%s' (fish_vcs_prompt)
    printf '\n'

    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    printf 'λ '
    set_color normal
end

function gwtc --description 'git worktree add ../<repo>.worktrees/<slug> and cd into it'
    if test (count $argv) -ne 1
        echo "usage: gwtc <slug>" >&2
        return 1
    end

    set -l root (git rev-parse --show-toplevel); or return
    set -l repo (basename $root)
    set -l dest (dirname $root)/$repo.worktrees/$argv[1]

    git worktree add $dest; and cd $dest
end

function withenv --description 'run a command with environment variables from a .env file'
    env (grep -v -e '^#' -e '^\s*$' .env) $argv
end

if status is-interactive
    # fnm
    if type -q fnm
        fnm env --use-on-cd --shell fish --resolve-engines | source
    end

    bind ctrl-backspace backward-kill-word
    bind ctrl-delete kill-word
    if test (uname) = Darwin
        bind ctrl-h backward-kill-word
    end

    # git
    abbr -a g git
    abbr -a ga git add
    abbr -a gb git branch
    abbr -a gc git commit
    abbr -a gca git commit --amend
    abbr -a gcan git commit --amend --no-edit
    abbr -a gcb git switch -c
    abbr -a gcm git commit -m
    abbr -a gco git checkout
    abbr -a gcp git cherry-pick
    abbr -a gd git diff
    abbr -a gfa git fetch --all --prune
    abbr -a gp git push
    abbr -a gpf git push --force-with-lease
    abbr -a gpr git pull --rebase
    abbr -a gr git rebase
    abbr -a grc git rebase --continue
    abbr -a gst git status -sb
    abbr -a gsu git stash -u
    abbr -a gsp git stash pop
    abbr -a gw git switch
    abbr -a gwt git worktree
    abbr -a gwta git worktree add
    abbr -a gwtl git worktree list
    abbr -a gwtp git worktree prune
    abbr -a gwtr git worktree remove

    # pnpm / node
    abbr -a pb pnpm run build
    abbr -a pd pnpm run dev
    abbr -a pt pnpm test
    abbr -a nr node --run

    abbr -a cls clear
    abbr -a we withenv
end

if command -q zoxide
    zoxide init fish --cmd cd | source
end
