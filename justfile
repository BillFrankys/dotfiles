#!/usr/bin/env just --justfile
#---------------------------- SETTINGS ---------------------------------------#
# allow to override earlier recipes with the same name.

set allow-duplicate-recipes := true

# load a .env file, if present.

set dotenv-load := true

# export all variables as environment variables.

set export := true

# pass positional arguments.

set positional-arguments := true

# set the command used to invoke recipes and evaluate backticks.

set shell := ["nu", "-c"]

# ignore recipe lines beginning with #.

set ignore-comments := true

# search justfile in parent directory

set fallback := true

#---------------------------- RECIPRE BLOCK-----------------------------------#

all_recipres := `just --summary`

# select one or more recipes to run using a binary
[no-cd]
[no-exit-message]
[private]
@default:
    just --list

# install all targets
[no-cd]
[no-exit-message]
[private]
all:
    @just {{ all_recipres }}

# format and overwrite justfile
[no-cd]
[no-exit-message]
[private]
@format:
    just --fmt --unstable

# install rustup
[linux]
[no-exit-message]
[private]
rustup:
    #!/usr/bin/sh
    command -v cargo >/dev/null 2>&1 ||  curl https://sh.rustup.rs | sh -s -- -y 

# install rustup
[no-exit-message]
[private]
[windows]
rustup:
    #!cmd.exe /c
    curl https://win.rustup.rs/x86_64 --output rustup-init.exe
    rustup-init.exe -y
    rm rustup-init.exe

# A Rust package manager
cargo: rustup

# A new type of shell.
nu: cargo
    @cargo install --locked nu

# A generator for the LS_COLORS environment variable
vivid: cargo
    @cargo install --locked vivid

# A program to find entries in your filesystem
fd: cargo
    @cargo install --locked fd-find

# A command-line benchmarking tool
hyperfine: cargo
    cargo install --locked hyperfine

# A command-line tool to generate, analyze, convert and manipulate colors
pastel: cargo
    @cargo install --locked pastel

# A line-oriented search tool
ripgrep: cargo
    @cargo install --locked ripgrep

# A simple, fast, and featureful alternative to rm and trash-cli written in rust
trashy: cargo
    @cargo install --locked trashy

# A project that patches developer targeted fonts with a high number of glyphs (icons)
[linux]
nerdfonts: nu
    @mkdir ~/.local/share/fonts
    @http get https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip | save -f FiraCode.zip
    @unzip -o FiraCode.zip  -d ~/.local/share/fonts
    @fc-cache  -v -r ~/.local/share/fonts
    @rm FiraCode.zip

# the minimal, blazing-fast, and infinitely customizable prompt for any shell
starship: cargo nerdfonts
    @cargo install starship --locked

# A tool version manager
asdf: nu
    @rm -rf ~/.asdf
    @git clone  https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3

# A command-line task management tool
pueue: cargo
    @cargo install --locked pueue

# Replaces your existing shell history with a SQLite database
[linux]
atuin: cargo nu
    @cargo install atuin
    @mkdir ~/.local/share/atuin/
    @atuin init nu | save -f ~/.local/share/atuin/init.nu

# Terminal utilities for accessing the Wayland clipboard
wl-clipboard: cargo
    @cargo install wl-clipboard-rs-tools

# A smarter cd command
zoxide: cargo nu
    @cargo install zoxide --locked
    @zoxide init nushell | save -f ~/.zoxide.nu

# A Kakoune / Neovim inspired editor, written in Rust
helix: cargo
    @cargo install --git https://github.com/helix-editor/helix helix-term
    @hx --grammar fetch
    @hx --grammar build

# A tui file manager with Vim-like key mapping, written in Rust.
felix: cargo
    @cargo install felix

# A fast, cross-platform, OpenGL terminal emulator
alacritty: cargo
    cargo install alacritty

# A utility to adjust opacity for Alacritty
alacritty-opacity: cargo
    cargo install alacritty-opacity

# A utility to generate color schemes for alacritty
colortty: cargo
    cargo install colortty

# A general-purpose command-line fuzzy finder.
[linux]
fzf: nu
    http get https://github.com/junegunn/fzf/releases/download/0.41.1/fzf-0.41.1-linux_amd64.tar.gz | tar xvzf -

# A general-purpose command-line fuzzy finder.
[windows]
fzf: nu
    http get https://github.com/junegunn/fzf/releases/download/0.41.1/fzf-0.41.1-{{ os_family() }}_amd64.tar.gz | tar xvzf -
