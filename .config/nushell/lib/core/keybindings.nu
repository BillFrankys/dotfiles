export def main [] { return {
    name: nupm
    modifier: control
    keycode: char_n
    mode: [emacs, vi_insert, vi_normal]
    event: {
        send: executehostcommand
        cmd: "overlay use --prefix nupm"
    }
}
}