#!/bin/bash

# set default dir
DOTFILES_DIR=${DOTFILES:-$HOME/dev/dotfiles}

# remove old config files
rm -rf $HOME/.zshrc $HOME/.tmux.conf $HOME/.config/nvim $HOME/.config/starship.toml $HOME/.warp $HOME/.config/ghostty

# link new config files
ln -s $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -s $DOTFILES_DIR/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES_DIR/.warp $HOME/.warp
ln -s $DOTFILES_DIR/nvim $HOME/.config/nvim
ln -s $DOTFILES_DIR/starship.toml $HOME/.config/starship.toml
ln -s $DOTFILES_DIR/ghostty $HOME/.config/ghostty
