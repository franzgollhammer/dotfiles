#!/bin/bash

# remove old config files
rm -rf ~/.zshrc ~/.tmux.conf ~/.config/nvim ~/.config/starship.toml ~/.warp ~/.config/ghostty

# link new config files
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.warp ~/.warp
ln -s ~/dev/dotfiles/nvim ~/.config/nvim
ln -s ~/dev/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dev/dotfiles/ghostty ~/.config/ghostty
