#!/usr/bin/env bash
sudo apt update
sudo apt upgrade
sudo apt install build-essential curl file git wget

# Install Homebrew (Linux)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

brew doctor

brew install stow zsh vim direnv ccat lsd socat

stow -t ~ stow

stow zsh
stow wsl
stow git

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

go get -d github.com/jstarks/npiperelay
mkdir -p ~/winhome/.wsl/
GOOS=windows go build -o ~/winhome/.wsl/npiperelay.exe github.com/jstarks/npiperelay
