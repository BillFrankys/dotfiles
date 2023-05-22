# Nushell Environment Config File
#
# version = 0.80.0

let-env STARSHIP_SHELL = "nu"
def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { || create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""
# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "
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



let-env NU_SCRIPTS_REMOTE = "https://github.com/goatfiles/nu_scripts.git"
let-env GIT_REPOS_HOME = "/home/dryam/Repositories"
let-env NU_SCRIPTS_DIR = ($env.GIT_REPOS_HOME | path join "github.com/goatfiles/nu_scripts")

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')

]


export-env {
    let-env NUPM_HOME = '/home/dryam/.local/share/nupm/'
    let-env NU_LIB_DIRS = ($env.NU_LIB_DIRS? | default [] | append [
        $env.NUPM_HOME
	$env.NU_SCRIPTS_DIR
    ])
}

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/dryam/.local/bin')

let-env NUPM_CONFIG = {
    activations: ...
    packages: ...
}



let-env DOTFILES_GIT_DIR = "/home/dryam/.dotfiles"
let-env DOTFILES_WORKTREE = "/home/dryam/.gists"
let-env GIST_HOME = "/home/dryam/"
let-env PROMPT_CONFIG = {
    compact: true            # whether to make the prompt compact or not
    section_separator: " | "  # the separator between sections
    overlay_separator: " < "  # the separator between overlays
}
