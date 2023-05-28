#!/usr/bin/env bash
set -x
export CARGO_HOME="$HOME/.local/share/cargo"

rm -rf $HOME/.local
mkdir -p $HOME/.local

cd ~/.local && curl https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh  |  sh -s --  --skip-license

curl https://sh.rustup.rs | CARGO_HOME="$HOME/.local/share/cargo" sh -s -- -y 

source $CARGO_HOME/env

curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

git clone --bare https://github.com/BillFrankys/dotfiles  "$HOME/.local/share/repos/dotfiles" --depth 1
git config --global alias.dtf '!git --git-dir=/home/dryam/.local/share/repos/dotfiles --work-tree=/home/dryam'
git --git-dir=/home/dryam/.local/share/repose/dotfiles --work-tree=/home/dryam config --local status.showUntrackedFiles no
git --git-dir=/home/dryam/.local/share/repose/dotfiles --work-tree=/home/dryam checkout -f

cargo binstall -y --force cargo-update nu

 
