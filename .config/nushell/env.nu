# Nushell Environment Config File
#
# version = 0.80.0

use std *

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

let-env XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
let-env XDG_CONFIG_HOME = ($env.HOME | path join ".config")
let-env XDG_STATE_HOME = ($env.HOME | path join ".local" "state")
let-env XDG_CACHE_HOME = ($env.HOME | path join ".cache")

# move all moveable config to the right location, outside $HOME.
let-env TERMINFO_DIRS = (
  [
      ($env.XDG_DATA_HOME | path join "terminfo")
      "/usr/share/terminfo"
  ]
  | str join ":"
)
let-env HISTFILE = ($env.XDG_STATE_HOME | path join "bash" "history")
let-env CARGO_HOME = ($env.XDG_DATA_HOME | path join "cargo")
let-env GNUPGHOME = ($env.XDG_DATA_HOME | path join "gnupg")
let-env PASSWORD_STORE_DIR = ($env.XDG_DATA_HOME | path join "pass")
let-env GOPATH = ($env.XDG_DATA_HOME | path join "go")
let-env GTK2_RC_FILES = ($env.XDG_CONFIG_HOME | path join "gtk-2.0" "gtkrc")
let-env JUPYTER_CONFIG_DIR = ($env.XDG_CONFIG_HOME | path join "jupyter")
let-env LESSHISTFILE = ($env.XDG_CACHE_HOME | path join "less" "history")
let-env TERMINFO = ($env.XDG_DATA_HOME | path join "terminfo")
let-env NPM_CONFIG_USERCONFIG = ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")
let-env PYTHONSTARTUP = ($env.XDG_CONFIG_HOME | path join "python" "pythonrc")
let-env SQLITE_HISTORY = ($env.XDG_CACHE_HOME | path join "sqlite_history")
let-env _Z_DATA = ($env.XDG_DATA_HOME | path join "z")
let-env BROWSER = "qutebrowser"
let-env TERMINAL = "alacritty -e"
# changes the editor in the terminal, to edit long commands.
let-env EDITOR = 'hx'
let-env VISUAL = $env.EDITOR
# make "less" man pages prettier
let-env LESS_TERMCAP_so = $"(tput bold; tput rev; tput setaf 3)"  # yellow
let-env MANPAGER = "sh -c 'col -bx | bat -l man -p'" ### "bat" as manpager
let-env WORKON_HOME = ($env.XDG_DATA_HOME | path join "virtualenvs")
let-env GIT_REPOS_HOME = ($env.XDG_DATA_HOME | path join "repos")
let-env DOTFILES_GIT_DIR = ($env.GIT_REPOS_HOME| path join "dotfiles")
let-env DOTFILES_WORKTREE = $env.HOME
let-env DOWNLOADS_DIR = ($env.HOME | path join "Downloads")

let-env NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")

let-env QT_QPA_PLATFORMTHEME = "qt5ct"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env PATH = (
    $env.PATH | split row (char esep)
    | prepend ($env.HOME | path join ".local" "bin")
    | prepend ($env.CARGO_HOME | path join "bin")
)

if not ($env.HOME | path join ".local" "bin" "carapace" | path exists) {
  print $"(ansi yellow_bold)WARNING(ansi reset): carapace does not exist..."
  print $"(ansi cyan)INFO   (ansi reset): pulling carapace-bin..."
  mkdir  ($env.HOME | path join ".local" "bin")
  http get  https://github.com/rsteube/carapace-bin/releases/download/v0.24.5/carapace-bin_linux_amd64.tar.gz | tar xvzf - -C  ($env.HOME | path join ".local" "bin") carapace
  print $"(ansi cyan)INFO   (ansi reset): carapace ready to use"
}

if not ( $env.CARGO_HOME | path join  "bin" "vivid" | path exists) {
  print $"(ansi yellow_bold)WARNING(ansi reset): vivid does not exist..."
  print $"(ansi cyan)INFO   (ansi reset): binstall vivid..."
  cargo binstall vivid  --force -y 
  print $"(ansi cyan)INFO   (ansi reset): vivid ready to use"
}

let-env LS_THEME = "gruvbox-dark-soft"
# Nushell will respect and use the LS_COLORS
let-env LS_COLORS = (vivid generate $env.LS_THEME | str trim)

let-env FZF_DEFAULT_OPTS = "
--bind ctrl-d:half-page-down
--bind ctrl-u:half-page-up
--bind shift-right:preview-half-page-down
--bind shift-left:preview-half-page-up
--bind shift-down:preview-down
--bind shift-up:preview-up
"


# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIR = ($nu.config-path | path dirname | path join 'lib')
let-env NU_SCRIPTS_REMOTE = "https://github.com/nushell/nu_scripts"
let-env NU_SCRIPTS_DIR = ($env.GIT_REPOS_HOME | path join "github.com/nushell/nu_scripts")

let-env NU_LIB_DIRS = [
    $env.NU_LIB_DIR
    $env.NU_SCRIPTS_DIR
    $env.NUPM_HOME
]

let-env NUPM_CONFIG = {
    activations: ($nu.default-config-dir | path join "nupm" "activations.nuon")
    packages: ($nu.default-config-dir | path join "nupm" "packages.nuon")
    set_prompt: false
}

#TODO: add more colors to messages
# Check if nu scripts available
if not ($env.NU_SCRIPTS_DIR | path exists) {
  print $"(ansi yellow_bold)WARNING(ansi reset): ($env.NU_SCRIPTS_DIR) does not exist..."
  print $"(ansi cyan)INFO   (ansi reset): pulling the scripts from ($env.NU_SCRIPTS_REMOTE)..."
  git clone $env.NU_SCRIPTS_REMOTE $env.NU_SCRIPTS_DIR
  print $"(ansi cyan)INFO   (ansi reset): ($env.NU_SCRIPTS_DIR) ready to use"
}

let-env DEFAULT_CONFIG_FILE = (
  $env.NU_LIB_DIR
  | path join "default_config.nu"
)
let-env DEFAULT_CONFIG_REMOTE = (
  "https://raw.githubusercontent.com/nushell/nushell/main/crates/nu-utils/src/sample_config/default_config.nu"
)

export def "config update default" [ --help (-h) ] {
  let name = ($env.DEFAULT_CONFIG_FILE | path basename)
  let default_url = ($env.DEFAULT_CONFIG_REMOTE | path join $name)

  if ($env.DEFAULT_CONFIG_FILE| path expand | path exists) {
    let new = (http get $default_url)
    let old = (open $env.DEFAULT_CONFIG_FILE)

    if $old != $new {
      $new | save --force --raw $env.DEFAULT_CONFIG_FILE
      print $'Updated ($name)'
    } else {
      print $'($name): No change'
    }
  } else {
    http get $default_url | save --force --raw $env.DEFAULT_CONFIG_FILE
    print $'Downloaded new ($name)'
  }
}

if not ($env.DEFAULT_CONFIG_FILE | path exists) {
  print $"(ansi red_bold)error(ansi reset): ($env.DEFAULT_CONFIG_FILE) does not exist..."
  print $"(ansi cyan)info(ansi reset): pulling default config file..."
  config update default
}

let-env PROMPT_MULTILINE_INDICATOR = {(
    (
      [(ansi red) (ansi yellow) (ansi green) (ansi reset)]
      | str join ")"
    ) + " "
)}

if not ( $env.CARGO_HOME | path join  "bin" "starship" | path exists) {
  print $"(ansi yellow_bold)WARNING(ansi reset): starship does not exist..."
  print $"(ansi cyan)INFO   (ansi reset): binstall starship..."
  cargo binstall starship  --force -y 
  print $"(ansi cyan)INFO   (ansi reset): starship ready to use"
}

# Prompt with Starship
let-env STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { || create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""

let-env NU_RIGHT_PROMPT_CONFIG = {
    compact: false            # whether to make the prompt compact or not
    section_separator: " | "  # the separator between sections
    overlay_separator: " < "  # the separator between overlays
    sections: ["shells", "overlays"]  # the sections displayed in the prompt
}

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

