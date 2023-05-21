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

# default target
@_default:
    just --list

status:
    git --git-dir=/home/dryam/.dotfiles/ --work-tree=/home/dryam status

add +files:
    git --git-dir=/home/dryam/.dotfiles/ --work-tree=/home/dryam add {{files}}