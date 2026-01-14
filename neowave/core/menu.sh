#!/usr/bin/env bash

# Set NEOWAVE_DIR if not already
NEOWAVE_DIR="${NEOWAVE_DIR:-$HOME/.config/neowave}"

# Source core scripts
source "$NEOWAVE_DIR/core/utils.sh"
source "$NEOWAVE_DIR/core/state.sh"
source "$NEOWAVE_DIR/core/logos.sh"
source "$NEOWAVE_DIR/core/colors.sh"
source "$NEOWAVE_DIR/core/apply.sh"
source "$NEOWAVE_DIR/core/actions.sh"

main_menu() {
    while true; do
        echo
        PS3="NEOWAVE > "

        select opt in \
            "Logos" \
            "Info Modules" \
            "Colors" \
            "Profiles" \
            "Actions" \
            "Exit"; do

            case $REPLY in
                1) logos_menu; break ;;
                2) info_modules_menu; break ;;
                3) colors_menu; break ;;
                4) echo "[Profiles menu coming soon]"; break ;;
                5) actions_menu; break ;;
                6) exit 0 ;;
                *) echo "Invalid selection";;
            esac
        done
    done
}

NEOFETCH_DIR="$HOME/.config/neofetch"
NEOFETCH_CONF="$NEOFETCH_DIR/config.conf"
NEOFETCH_ORIG="$NEOFETCH_DIR/config.conf.original"

ensure_neofetch_exists() {
    if [[ ! -f "$NEOFETCH_CONF" ]]; then
        echo "✖ Neofetch config not found."
        echo "Run neofetch once before using NEOWAVE."
        return 1
    fi
    return 0
}

backup_original_config() {
    ensure_neofetch_exists || return

    if [[ ! -f "$NEOFETCH_ORIG" ]]; then
        cp "$NEOFETCH_CONF" "$NEOFETCH_ORIG"
        echo "✔ Original Neofetch config backed up"
    fi
}

restore_original_config() {
    if [[ -f "$NEOFETCH_ORIG" ]]; then
        read -p "Restore original Neofetch config? [y/N]: " confirm
        [[ "$confirm" != "y" ]] && return

        cp "$NEOFETCH_ORIG" "$NEOFETCH_CONF"
        echo "✔ Original config restored"
    else
        echo "✖ No original backup found"
    fi
}

info_modules_menu() {
    local options=("cpu" "gpu" "memory" "os" "back")
    while true; do
        echo
        PS3="Info Modules > "
        select opt in "${options[@]}"; do
            case $REPLY in
                1|2|3|4)
                    # Toggle module in STATE_ENABLED_MODULES
                    if [[ " ${STATE_ENABLED_MODULES[*]} " == *" $opt "* ]]; then
                        # Remove
                        STATE_ENABLED_MODULES=("${STATE_ENABLED_MODULES[@]/$opt}")
                        echo "✖️ Module '$opt' removed"
                    else
                        # Add
                        STATE_ENABLED_MODULES+=("$opt")
                        echo "✔️ Module '$opt' added"
                    fi
                    break
                    ;;
                5) return ;;  # Back
                *) echo "✖️ Invalid selection";;
            esac
        done
    done
}
