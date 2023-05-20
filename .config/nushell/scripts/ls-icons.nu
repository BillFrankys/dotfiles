# A more standart variant of ls
def ls-icons [
    path: path = '.'
    --separator (-s): string = '   '
    ] {
    ls $path  | grid -c  --separator $separator
}