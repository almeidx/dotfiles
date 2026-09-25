# source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting; end

if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

set -gx PNPM_HOME $HOME/.local/share/pnpm

fish_add_path -g \
    $HOME/.local/bin \
    $PNPM_HOME/bin

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

function claudex --wraps claude --description 'claude via local gateway'
    set -l model gpt-6-astra

    env -u ANTHROPIC_API_KEY -u CLAUDE_CODE_OAUTH_TOKEN \
        ANTHROPIC_BASE_URL=http://127.0.0.1:8317 \
        ANTHROPIC_AUTH_TOKEN=$CLAUDEX_AUTH_TOKEN \
        ANTHROPIC_DEFAULT_OPUS_MODEL=$model \
        ANTHROPIC_DEFAULT_SONNET_MODEL=$model \
        ANTHROPIC_DEFAULT_HAIKU_MODEL=$model \
        CLAUDE_CODE_SUBAGENT_MODEL=$model \
        CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1 \
        CLAUDE_CODE_MAX_CONTEXT_TOKENS=1050000 \
        CLAUDE_CODE_AUTO_COMPACT_WINDOW=900000 \
        ENABLE_TOOL_SEARCH=false \
        claude --model $model $argv
end

if status is-interactive
    # fnm
    if type -q fnm
        fnm env --use-on-cd --shell fish --resolve-engines | source
    end

    bind ctrl-backspace backward-kill-word
    bind ctrl-delete kill-word

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

    # pnpm / node
    abbr -a pb pnpm run build
    abbr -a pd pnpm run dev
    abbr -a pt pnpm test
    abbr -a nr node --run

    abbr -a cls clear
end
