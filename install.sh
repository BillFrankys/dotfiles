#!/usr/bin/env bash
set -x
export CARGO_HOME="$HOME/.local/share/cargo"

rm -rf $HOME/.local
mkdir -p $HOME/.local

curl https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.tar.gz  -s -L |  tar xzf - -C /tmp
mv /tmp/cmake-3.26.4-linux-x86_64/*   $HOME/.local/
rm -rf /tmp/cmake-3.26.4-linux-x86_64

curl https://sh.rustup.rs | CARGO_HOME="$HOME/.local/share/cargo" sh -s -- -y 

source $CARGO_HOME/env
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

cargo binstall -y --force cargo-update nu



git clone --bare https://github.com/BillFrankys/dotfiles  "$HOME/.local/share/.dotfiles" --depth 1
git config --global alias.dtf '!git --git-dir=/home/dryam/.local/share/.dotfiles --work-tree=/home/dryam'
git --git-dir=/home/dryam/.local/share/.dotfiles --work-tree=/home/dryam config --local status.showUntrackedFiles no
git --git-dir=/home/dryam/.local/share/.dotfiles --work-tree=/home/dryam checkout -f


# rm -rf HOME/.dotfiles
# git clone --bare https://github.com/BillFrankys/dotfiles  $HOME/.dotfiles
# git --git-dir=$HOME/.dotfiles/ config --local status.showUntrackedFiles no

# alacritty alacritty-opacity asdf atuin carapace cargo colortty fd felix fzf helix hyperfine nerdfonts nu pastel pueue ripgrep starship trashy vivid wl-clipboard zoxide
 
