#!/bin/bash

# Replace the default zshrc with the one on this repo
mv ~/.zshrc ~/.zshrc.old
mv .zshrc.new ~/.zshrc

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install JetBrains Mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip
unzip JetBrainsMono-2.001.zip -d /tmp/jetbrains-mono
mv /tmp/jetbrains-mono/ttf/* /usr/share/fonts/truetype
sudo fc-cache -f -v

# Install fnm
curl -fsSL https://fnm.vercel.app/install | bash

# Git config
git config --global pull.rebase true
git config --global push.autoSetupRemote true

# Git Aliases
git config --global alias.ci "commit -m"
git config --global alias.co "checkout"
git config --global alias.cm "checkout main"
git config --global alias.cb "checkout -b"
git config --global alias.st "status -sb"
git config --global alias.sf "show --name-only"
git config --global alias.lg "log --pretty=format:'%Cred%h%Creset %C(bold)%cr%Creset %Cgreen<%an>%Creset %s' --max-count=30"
git config --global alias.incoming "!(git fetch --quiet && git log --pretty=format:'%C(yellow)%h %C(white)- %C(red)%an %C(white)- %C(cyan)%d%Creset %s %C(white)- %ar%Creset' ..@{u})"
git config --global alias.outgoing "!(git fetch --quiet && git log --pretty=format:'%C(yellow)%h %C(white)- %C(red)%an %C(white)- %C(cyan)%d%Creset %s %C(white)- %ar%Creset' @{u}..)"
git config --global alias.unstage "reset HEAD --"
git config --global alias.undo "checkout --"
git config --global alias.rb "reset --soft HEAD~1"
git config --global alias.committers "!(git log | grep Author | sort | uniq -c | sort -n -r)"
git config --global alias.clean "git clean -df"
git config --global alias.resign "!f() { git rebase --exec 'git commit --amend --no-edit -n -S' -i $1; }; f"
git config --global alias.resignlast "rebase --exec 'git commit --amend --no-edit -n -S'"
git config --global alias.rename "!sh -c 'git branch -m `git rev-parse --abbrev-ref HEAD` $1'"
git config --global alias.amend "commit --amend --no-edit -m"
git config --global alias.cim "!sh -c 'git commit -m \"`curl https://whatthecommit.com/index.txt`\"'"
git config --global alias.cimc "!sh -c 'git commit -m \"chore: `curl https://whatthecommit.com/index.txt`\"'"
