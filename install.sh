#!/usr/bin/env bash
export CARGO_HOME="$HOME/.local/share/cargo"

rm -rf $HOME/.local
mkdir -p $HOME/.local

cd ~/.local && curl https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh  |  sh -s --  --skip-license

curl https://sh.rustup.rs | CARGO_HOME="$HOME/.local/share/cargo" sh -s -- -y 

source $CARGO_HOME/env

curl -o- -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

echo "## Clone dotfiles:"
git clone --bare https://github.com/BillFrankys/dotfiles  "$HOME/.local/share/repos/dotfiles" --depth 1

echo "## Checkout dotfiles:"
git --git-dir=/home/dryam/.local/share/repos/dotfiles --work-tree=/home/dryam checkout -f

echo "## Config git dotfiles alias:"
git config --global alias.dotfiles '!git --git-dir=/home/dryam/.local/share/repos/dotfiles --work-tree=/home/dryam'

echo "## Config git untracked files:"
git dotfiles config --local status.showUntrackedFiles no


#cargo binstall -y --force cargo-update nu alacritty alacritty-opacity asdf atuin colortty fd-find felix  hyperfine pastel pueue ripgrep starship trashy vivid  zoxide

 
