#!/usr/bin/env bash

HISTORY_DIR="$HOME/.cache/cliphist_text"
MAX_HISTORY=30

write_file() {
    HISTORY_FILE="$HISTORY_DIR/.$(date +%Y-%m-%d_%H-%M-%S)"
    if [ ! -f $HISTORY_FILE ]; then
        touch $HISTORY_FILE
        CLIPBOARD=$(echo "$1")
        echo "$CLIPBOARD" > "$HISTORY_FILE"
    fi
}

prune() {
    local count=$(ls -ta "$HISTORY_DIR" | wc -l)
    if [ "$count" -gt 31 ]; then
        ls -ta "$HISTORY_DIR" | tail -n +32 | xargs -I{} rm "$HISTORY_DIR/{}"
    fi
}

add() {
    # adds selection to history
    PASTE=$(wl-paste)

    # dont add paste to history if it's already the most recent history item
    LATEST=$(ls -tap "$HISTORY_DIR" | grep -v '/' | head -n 1)
    if [ -n "$LATEST" ] && [ "$(cat "$HISTORY_DIR/$LATEST")" = "$PASTE" ]; then
        return 0
    fi

    # Remove any older duplicates
    grep -rlx "$PASTE" "$HISTORY_DIR" | xargs -r rm

    write_file "$PASTE"
    prune
}

list() {
    fzf --walker-root=$HISTORY_DIR --preview "bat --color=always --style=numbers --line-range=:500 {}"
}

sel() {
    SELECTION=$(ls -tap "$HISTORY_DIR" | grep -v '/' | \
        fzf --preview "bat --color=always --style=numbers --line-range=:500 $HISTORY_DIR/{}" \
            --preview-window=right:75% \
            --delimiter / \
            --with-nth -1 \
            --bind "del:execute-silent(rm $HISTORY_DIR/{})+reload(ls -tap $HISTORY_DIR | grep -v /)")
    
    if [ -n "$SELECTION" ]; then
        cat "$HISTORY_DIR/$SELECTION" | wl-copy
    fi
}

case "$1" in
    add) add ;;
    ls) list ;;
    sel) sel ;;
    *) echo "script to add/clear/list/select clipboard history items"
esac

