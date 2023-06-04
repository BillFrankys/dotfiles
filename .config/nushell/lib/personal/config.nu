# Show dotfiles status
export def "status" [] {
    git dotfiles status -u --short | str replace -a "\\?\\?" 'untracked' | str replace -a "A " "added" | str replace -a " M" "modified" |  lines | str trim --left | parse "{status} {filename}"
  }

# Show dotfiles changes
export def "changes" [] {
    let choice = (status | where status == modified | get filename | input list -m )
    git dotfiles diff $choice
}

# Restore dotfiles to last state.
export def "restore" [] {
    let choice = (status | where status == modified | get filename | input list -m )
    git dotfiles checkout $choice
}

# Fully reset dotfiles and clean files.
export def "reset" [] {
    let choice = ( ["yes", "no"] | input list "Are you sure want to reset?")
     if $choice == "yes" {  git dotfiles clean -f }
}

# Save modified dotfiles. 
export def "save" [] {
    let choice = ( status | where status == modified  |  get filename | input list -m | ansi strip )
    git dotfiles add $choice
    git dotfiles commit -m "update dotfiles"
    git dotfiles push --set-upstream origin main
}

# Save untracked dotfiles. 
export def "add" [] {
    let choice = ( status | where status == untracked  |  get filename | input list -m | ansi strip )
    git dotfiles add $choice
    git dotfiles commit -m "added new dotfiles"
    git dotfiles push --set-upstream origin main
}