#!/usr/bin/env bash
set -x
curl https://sh.rustup.rs | sh -s -- -y 
source ~/.cargo/env
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall -y --force cargo-update nu

rm -rf $HOME/.dotfiles
rm -rf $HOME/.local/share/.dotfiles
mkdir -p $HOME/.local/share/
git clone --bare https://github.com/BillFrankys/dotfiles  "$HOME/.local/share/.dotfiles" --depth 1
git config --global alias.dtf '!git --git-dir=/home/dryam/.local/share/.dotfiles --work-tree=/home/dryam'
git --git-dir=/home/dryam/.local/share/.dotfiles --work-tree=/home/dryam config --local status.showUntrackedFiles no
git --git-dir=/home/dryam/.local/share/.dotfiles --work-tree=/home/dryam checkout -f


# rm -rf HOME/.dotfiles
# git clone --bare https://github.com/BillFrankys/dotfiles  $HOME/.dotfiles
# git --git-dir=$HOME/.dotfiles/ config --local status.showUntrackedFiles no

# alacritty alacritty-opacity asdf atuin carapace cargo colortty fd felix fzf helix hyperfine nerdfonts nu pastel pueue ripgrep starship trashy vivid wl-clipboard zoxide
