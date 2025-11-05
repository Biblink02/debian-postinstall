ask() {
    [ "${AUTO:-0}" = "1" ] && return 0
    read -rp "$1 (y/n): " a
    [[ "$a" =~ ^[Yy]$ ]]
}

merge_block() {
    src="$1"; dest="$2"; tag="# >>> debian-postinstall"
    mkdir -p "$(dirname "$dest")"; touch "$dest"
    sed -i "/$tag BEGIN/,/$tag END/d" "$dest"
    {
        echo "$tag BEGIN"
        grep -vE '^[[:space:]]*(#|$)' "$src"
        echo "$tag END"
    } >> "$dest"
}
