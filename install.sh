#!/usr/bin/env bash
sudo apt update
sudo apt upgrade
sudo apt install build-essential curl file git wget

# Install Homebrew (Linux)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

brew doctor
brew bundle

stow -t ~ stow

stow zsh
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

stow wsl
stow git
git lfs install

brew install ruby go python node

pip3 install click

# Install Deno
curl -fsSL https://deno.land/x/install/install.sh | sh

stow go
stow deno
stow python3

echo "/home/linuxbrew/.linuxbrew/bin/zsh" | sudo tee -a

CURRENT_USER="$(whoami)"
WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2> /dev/null | sed -e 's/\r//g')

sudo usermod -s /home/linuxbrew/.linuxbrew/bin/zsh $CURRENT_USER

ln -s /mnt/c/Users/$WIN_USER ~/winhome

GOOS=windows go get -d github.com/jstarks/npiperelay
mkdir -p ~/winhome/.wsl/
GOOS=windows go build -o ~/winhome/.wsl/npiperelay.exe github.com/jstarks/npiperelay

# Install WSL Hello sudo
./wsl/wsl-hello-sudo/install.sh
