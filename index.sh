# add and list tasks
t () {

    if [ ! -f ~/.todo ]; then
        touch ~/.todo
    fi

    if [ ! -z "$1" ]; then
        echo "- $1" >> ~/.todo
    else 
        while read -r p; do
            echo -e "$p"
        done <~/.todo
    fi
}

# removes tasks
tt () {

    if [ ! -f ~/.todo ]; then
        touch ~/.todo
    fi

    oldIFS="$IFS"
    IFS='
    '
    IFS=${IFS:0:1}
    options=('exit')
    options+=($(cat ~/.todo | grep -v "e\[0m"))
    IFS="$oldIFS"

    PS3='Select a task to complete:'
    select opt in "${options[@]}"
    do
        case $opt in
            exit) break;;
            *) sed -i "s/$opt/- \\\\e[9m$opt\\\\e[0m/" ~/.todo; break;; 
        esac
    done

}
