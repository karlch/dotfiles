#!/bin/sh

# Create needed directories
mkdir -p ~/.config

# Initialize all folders using stow
# To remove parts simply comment them
stow config -t ~/.config
stow i3 -t ~
stow ncmpcpp -t ~
stow scripts -t ~
stow tmux -t ~
stow vim -t ~
stow xorg -t ~
stow zsh -t ~
