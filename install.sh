#!/usr/bin/env bash
export CARGO_HOME="$HOME/.local/share/cargo"

rm -rf $HOME/.local
mkdir -p $HOME/.local

echo "### Installing cmake:"
cd ~/.local &&  curl   -L --proto '=https' --tlsv1.2 -sSf https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh --output cmake-3.26.4-linux-x86_64.sh  && bash ./cmake-3.26.4-linux-x86_64.sh --skip-license

echo "### Installing rustup:"
curl https://sh.rustup.rs | CARGO_HOME="$HOME/.local/share/cargo" sh -s -- -y -c cargo clippy llvm-tools-preview rust-analyzer-preview rust-analysis rust-docs rust-src rust-std rustc rustc-dev rustfmt 

source $CARGO_HOME/env
. $CARGO_HOME/env

echo "### Installing cargo-binstall:"
curl -o- -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

echo "### Clone dotfiles:"
git clone --bare https://github.com/BillFrankys/dotfiles  "$HOME/.local/share/repos/dotfiles" --depth 1

echo "### Checkout dotfiles:"
git --git-dir=/home/dryam/.local/share/repos/dotfiles --work-tree=/home/dryam checkout -f

echo "### Config git dotfiles alias:"
git config --global alias.dotfiles '!git --git-dir=/home/dryam/.local/share/repos/dotfiles --work-tree=/home/dryam'

echo "### Config git untracked files:"
git dotfiles config --local status.showUntrackedFiles no

echo "### Binstall apps:"
CARGO_HOME="$HOME/.local/share/cargo"  cargo binstall -y --force cargo-update nu asdf atuin fd-find pueue ripgrep starship trashy vivid zoxide lsd bat alacritty zellij wl-clipboard-rs-tools git-delta

echo "### Install helix"
curl -o- -L --proto '=https' --tlsv1.2 -sSf https://github.com/helix-editor/helix/releases/download/23.05/helix-23.05-x86_64-linux.tar.xz  | tar xfJ - -C /tmp
mkdir -p ~/.config/helix/
cp -r /tmp/helix-23.05-x86_64-linux/runtime/ ~/.config/helix/
cp -r /tmp/helix-23.05-x86_64-linux/hx ~/.local/bin/
rm -rf /tmp/helix-23.05-x86_64-linux/hx

echo "### Install nerfont FiraCode"
mkdir -p ~/.local/share/fonts
curl -o- -L --proto '=https' --tlsv1.2 https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.tar.xz |  tar xvfJ - -C  ~/.local/share/fonts
fc-cache  -v -r ~/.local/share/fonts || true

echo "### Enable pueued service"
set -x
systemctl --user  kill  pueued
systemctl --user daemon-reload
systemctl --user --no-block start pueued

echo "### All done"
