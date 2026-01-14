#!/usr/bin/env bash

COLORS_DIR="$NEOWAVE_DIR/colors"

colors_menu() {
    mkdir -p "$COLORS_DIR"

    # List available presets
    mapfile -t presets < <(ls "$COLORS_DIR" 2>/dev/null | grep -E '\.sh$')

    if [[ ${#presets[@]} -eq 0 ]]; then
        echo "No color presets found."
        echo "Drop .sh preset files into:"
        echo "  $COLORS_DIR"
        return
    fi

    while true; do
        echo
        PS3="Colors > "
        select preset_file in "${presets[@]}" "Back"; do
            # Exit if user chooses Back or empty
            if [[ "$preset_file" == "Back" ]] || [[ -z "$preset_file" ]]; then
                return
            fi

            # Verify file exists
            if [[ -f "$COLORS_DIR/$preset_file" ]]; then
                STATE_COLOR_PRESET="$preset_file"
                STATE_DIRTY=true
                echo "✔️ Color preset '$preset_file' selected"

                # Show live preview using your apply.sh preview_config
                if declare -f preview_config >/dev/null 2>&1; then
                    echo
                    echo "=== LIVE PREVIEW ==="
                    preview_config
                    echo "==================="
                fi

                break  # back to menu
            else
                echo "✖️ Invalid selection, try again."
            fi
        done
    done
}
