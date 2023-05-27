# Nushell Config File
#
# version = 0.80.0
source personal/aliases.nu
source default_config.nu

use core/themes.nu
use core/hooks.nu
use core/completions.nu

# source-env core/menus.nu
# source-env core/keybindings.nu

# External completer example

let carapace_completer = {|spans|
    carapace $spans.0 nushell $spans | from json
}

let custom_config = {
  edit_mode: emacs  # emacs, vi
  show_banner: false
  shell_integration: false
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  buffer_editor: $env.EDITOR # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  bracketed_paste: true # enable bracketed paste, currently useless on windows
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
  color_config:  (themes gruvbox-dark-medium)  # if you want a light theme, replace `$dark_theme` to `$light_theme`
  hooks: (hooks)
  # menus: (menus)
  # keybindings: (keybindings)
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  rm: {
    always_trash: true
  }
  cd: {
    abbreviations: true
  }
  table: {
    mode: reinforced # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: auto # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }
  completions: {
  case_sensitive: false # set to true to enable case-sensitive completions
  quick: true  # set this to false to prevent auto-selecting completions when only one remains
  partial: true  # set this to false to prevent partial filling of the prompt
  algorithm: "prefix"  # prefix or fuzzy
  external: {
    enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
    max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
    completer: $carapace_completer # check 'carapace_completer' above as an example
  }
}
  history: {
    max_size: 10000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "sqlite" # "sqlite" or "plaintext"
    history_isolation: false # true enables history isolation, false disables it. true will allow the history to be isolated to the current session. false will allow the history to be shared across all sessions.
  }
  cursor_shape: {
    emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
    vi_insert: block # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
    vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
  }
}

let-env config = ($env.config | merge $custom_config)