#!/bin/bash

# Replace the default zshrc with the one on this repo
mv ~/.zshrc ~/.zshrc.old
mv .zshrc.new ~/.zshrc

# Install Spaceship
ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Install batcat
sudo apt install -y bat
