#!/usr/bin/env bash

source "$NEOWAVE_DIR/core/apply.sh"
source "$NEOWAVE_DIR/core/backup.sh"

actions_menu() {
    while true; do
        echo
        PS3="Actions > "
        select action in \
            "Preview NEOWAVE Config" \
            "Apply NEOWAVE Config" \
            "Restore Original Config" \
            "Back"; do

            case $REPLY in
                1) preview_config; break ;;
                2) apply_config; break ;;
                3) restore_original_config; break ;;
                4) return ;;
                *) echo "Invalid selection";;
            esac
        done
    done
}
