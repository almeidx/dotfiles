autoload -Uz compinit vcs_info
compinit

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt AUTO_CD
setopt PROMPT_SUBST

bindkey '\e[1;5C' forward-word       # Ctrl+Right
bindkey '\e[1;5D' backward-word      # Ctrl+Left
bindkey '\e[H'    beginning-of-line  # Home
bindkey '\e[F'    end-of-line        # End
bindkey '\e[3~'   delete-char        # Delete
bindkey '^H'      backward-kill-word # Ctrl+Backspace
bindkey '\e[3;5~' kill-word          # Ctrl+Delete

# Git branch
zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
}

PROMPT='%F{cyan}%~%f${vcs_info_msg_0_}
%F{green}λ%f '

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# fnm
eval "$(fnm env --shell=zsh --use-on-cd --resolve-engines)"

# Git shortcuts
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
alias p='pnpm'
alias pi='pnpm install'
alias pb='pnpm run build'
alias pd='pnpm run dev'
alias pt='pnpm test'

# Other shortcuts
alias cls='clear'
alias nr='node --run'
