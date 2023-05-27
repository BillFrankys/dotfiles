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
git --git-dir="$HOME/.local/share/.dotfiles" config --local status.showUntrackedFiles no
git --git-dir="$HOME/.local/share/.dotfiles" --work-tree="$HOME" checkout -f


# rm -rf HOME/.dotfiles
# git clone --bare https://github.com/BillFrankys/dotfiles  $HOME/.dotfiles
# git --git-dir=$HOME/.dotfiles/ config --local status.showUntrackedFiles no

# alacritty alacritty-opacity asdf atuin carapace cargo colortty fd felix fzf helix hyperfine nerdfonts nu pastel pueue ripgrep starship trashy vivid wl-clipboard zoxide
