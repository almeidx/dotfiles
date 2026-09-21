source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

# General
set -g fish_greeting

# keybindings
bind \e\[1\;5C forward-word       # Ctrl+Right
bind \e\[1\;5D backward-word      # Ctrl+Left
bind \e\[H beginning-of-line      # Home
bind \e\[F end-of-line            # End
bind \e\[3\~ delete-char          # Delete
bind \cH backward-kill-word       # Ctrl+Backspace
bind \e\[3\;5\~ kill-word         # Ctrl+Delete

# prompt
function fish_prompt
    set_color cyan
    printf '%s' (prompt_pwd)

    set_color yellow
    printf '%s' (fish_vcs_prompt)

    printf '\n'
    set_color green
    printf 'λ '
    set_color normal
end

# homebrew
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

# fnm
if type -q fnm
    fnm env --use-on-cd --shell fish --resolve-engines | source
end

# git shortcuts
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcb='git switch -c'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gfa='git fetch --all --prune'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gst='git status -sb'
alias gsu='git stash -u'
alias gsp='git stash pop'
alias gw='git switch'

# pnpm shortcuts
alias pb='pnpm run build'
alias pd='pnpm run dev'
alias pt='pnpm test'

# Other shortcuts
alias cls='clear'
alias nr='node --run'
