#!/usr/bin/env bash

# Install Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval $(brew shellenv)

brew doctor

brew install stow zsh vim direnv ccat lsd socat

stow -t ~ stow

stow zsh
stow git

brew install ruby go python node pipx

pip3 install click

# Install Deno
curl -fsSL https://deno.land/x/install/install.sh | sh

stow go
stow deno
stow python3
stow pyenv
