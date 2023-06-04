# Show dotfiles status
export def "status" [] {
    git dotfiles status -u --short | str replace -a "\\?\\?" 'untracked' | str replace -a "A " "added" | str replace -a " M" "modified" |  lines | str trim --left | parse "{status} {filename}"
  }

# Show dotfiles changes
export def "diff" [] {
    git dotfiles diff
}

# Restore dotfiles to last state.
export def "restore" [] {
    let choice = (config status | where status == modified | get filename | input list -m )
    git dotfiles checkout $choice
}

# Save dotfiles changes
export def "save" [] {
    let choice = (config status | where status != added | get filename | input list -m )
    git dotfiles add $choice
    git dotfiles commit -m "update dotfiles"
    git dotfiles push --set-upstream origin main
}
