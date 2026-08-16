ask_for_sudo() {
    if ! sudo -v &>/dev/null; then
        echo "error: you need sudo privileges to run this."
        exit 1
    fi

    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
}
