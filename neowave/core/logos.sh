#!/usr/bin/env bash

# -------------------------------
# Directories & Files
# -------------------------------
ASCII_DIR="$NEOWAVE_DIR/ascii"
CUSTOM_ASCII_DIR="$ASCII_DIR/custom"
DISTRO_DIR="$ASCII_DIR/distros"
DISTRO_DB="$NEOWAVE_DIR/data/distros.db"

# -------------------------------
# Select Distro ASCII Logo
# -------------------------------
select_distro() {
    [[ ! -f "$DISTRO_DB" ]] && echo "✖️ Distro DB missing: $DISTRO_DB" && return

    while true; do
        echo
        echo "Available distros:"
        echo "------------------"
        while IFS="|" read -r id name; do
            printf "[%s] %s\n" "$id" "$name"
        done < "$DISTRO_DB"
        echo "[0] Back"
        echo

        read -p "Select distro ID: " choice
        [[ "$choice" == "0" ]] && return

        if grep -q "^$choice|" "$DISTRO_DB"; then
            STATE_LOGO_MODE="distro"
            STATE_DISTRO_ID="$choice"
            STATE_CUSTOM_LOGO=""  # reset custom if switching
            echo "✔️ Distro logo set"

            # Live preview
            local distro_name distro_file
            distro_name=$(grep "^$STATE_DISTRO_ID|" "$DISTRO_DB" | cut -d"|" -f2)
            distro_file="$DISTRO_DIR/$distro_name.ascii"

            echo
            echo "=== LIVE PREVIEW ==="
            if [[ -f "$distro_file" ]]; then
                cat "$distro_file"
            else
                echo "$distro_name (ASCII file missing!)"
            fi
            echo "==================="
            return
        else
            echo "✖️ Invalid ID"
        fi
    done
}

# -------------------------------
# Select Custom ASCII Logo
# -------------------------------
select_custom_logo() {
    mkdir -p "$CUSTOM_ASCII_DIR"
    mapfile -t files < <(ls "$CUSTOM_ASCII_DIR" 2>/dev/null | grep -E '\.ascii$')

    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No custom ASCII files found."
        echo "Drop .ascii files into:"
        echo "  $CUSTOM_ASCII_DIR"
        return
    fi

    while true; do
        echo
        PS3="Custom Logo > "
        select file in "${files[@]}" "Back"; do
            if [[ "$file" == "Back" ]]; then
                return
            fi

            local full_path="$CUSTOM_ASCII_DIR/$file"
            if [[ -f "$full_path" ]]; then
                STATE_LOGO_MODE="custom"
                STATE_CUSTOM_LOGO="$full_path"
                STATE_DISTRO_ID=""  # reset distro if switching
                echo "✔️ Custom logo selected"

                # Live preview
                echo
                echo "=== LIVE PREVIEW ==="
                cat "$STATE_CUSTOM_LOGO"
                echo "==================="
                return
            else
                echo "✖️ Invalid selection"
            fi
        done
    done
}

# -------------------------------
# Main Logos Menu
# -------------------------------
logos_menu() {
    while true; do
        echo
        PS3="Logos > "
        select opt in \
            "Select ASCII Distro" \
            "Use Custom ASCII Art" \
            "Back"; do

            case $REPLY in
                1) select_distro; break ;;
                2) select_custom_logo; break ;;
                3) return ;;
                *) echo "✖️ Invalid selection" ;;
            esac
        done
    done
}

# -------------------------------
# Colors Menu
# -------------------------------
colors_menu() {
    COLOR_DIR="$NEOWAVE_DIR/colors"
    mkdir -p "$COLOR_DIR"
    mapfile -t files < <(ls "$COLOR_DIR" 2>/dev/null | grep -E '\.sh$')

    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No color presets found."
        echo "Drop .sh files into:"
        echo "  $COLOR_DIR"
        return
    fi

    while true; do
        echo
        PS3="Colors > "
        select file in "${files[@]}" "Back"; do
            if [[ "$file" == "Back" ]]; then
                return
            fi

            local full_path="$COLOR_DIR/$file"
            if [[ -f "$full_path" ]]; then
                STATE_COLOR_PRESET="$file"
                echo "✔️ Color preset '$file' selected"
                return
else
                echo "✖️ Invalid selection"
            fi
        done
    done
}
