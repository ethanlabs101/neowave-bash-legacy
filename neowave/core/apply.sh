#!/usr/bin/env bash

# -------------------------------
# Directories & Files
# -------------------------------
NEOFETCH_DIR="$HOME/.config/neofetch"
TMP_CONF="$NEOFETCH_DIR/config.conf.neowave.tmp"
ACTIVE_CONF="$NEOFETCH_DIR/config.conf"

ASCII_DIR="$NEOWAVE_DIR/ascii"
CUSTOM_ASCII_DIR="$ASCII_DIR/custom"
DISTRO_DB="$NEOWAVE_DIR/data/distros.db"
COLOR_DIR="$NEOWAVE_DIR/colors"

# -------------------------------
# Generate NEOWAVE config
# -------------------------------
generate_config() {
    mkdir -p "$NEOFETCH_DIR"

    # Start fresh
    echo "# NEOWAVE GENERATED CONFIG" > "$TMP_CONF"
    echo >> "$TMP_CONF"

    # -------------------------------
    # ASCII LOGO
    # -------------------------------
    if [[ "$STATE_LOGO_MODE" == "distro" ]]; then
        distro_name=$(grep "^$STATE_DISTRO_ID|" "$DISTRO_DB" | cut -d"|" -f2)
        ascii_distro="$distro_name"
        echo "ascii_distro=\"$ascii_distro\"" >> "$TMP_CONF"

    elif [[ "$STATE_LOGO_MODE" == "custom" ]]; then
        ascii_name="$(basename "$STATE_CUSTOM_LOGO" .ascii)"
        ascii_distro="$ascii_name"
        echo "ascii_distro=\"$ascii_distro\"" >> "$TMP_CONF"
        echo "ascii_path=\"$STATE_CUSTOM_LOGO\"" >> "$TMP_CONF"
    fi

    echo >> "$TMP_CONF"

    # -------------------------------
    # COLORS
    # -------------------------------
    if [[ -n "$STATE_COLOR_PRESET" ]]; then
        COLORS_FILE="$COLOR_DIR/$STATE_COLOR_PRESET"
        if [[ -f "$COLORS_FILE" ]]; then
            source "$COLORS_FILE"
            [[ -n "$LOGO_COLOR" ]] && echo "ascii_colors=($LOGO_COLOR)" >> "$TMP_CONF"
            if [[ -n "$KEY_COLOR" && -n "$VALUE_COLOR" && -n "$SEPARATOR_COLOR" && -n "$UNDERLINE_COLOR" ]]; then
                echo "info_colors=($KEY_COLOR $VALUE_COLOR $SEPARATOR_COLOR $UNDERLINE_COLOR)" >> "$TMP_CONF"
            fi
        fi
    fi

    echo >> "$TMP_CONF"

    # -------------------------------
    # INFO MODULES
    # -------------------------------
    echo "print_info() {" >> "$TMP_CONF"
    for module in "${STATE_ENABLED_MODULES[@]}"; do
        echo "    info \"$module\" $module" >> "$TMP_CONF"
    done
    echo "}" >> "$TMP_CONF"

    echo >> "$TMP_CONF"

    # -------------------------------
    # Alignment & right side display
    # -------------------------------
    echo "# Ensure info prints to the right" >> "$TMP_CONF"
    echo "right_width=50" >> "$TMP_CONF"
}

# -------------------------------
# Preview
# -------------------------------
preview_config() {
    generate_config
    echo
    echo "=== NEOWAVE CONFIG PREVIEW ==="
    echo
    neofetch --config "$TMP_CONF"
    echo
    echo "=============================="
}

# -------------------------------
# Apply
# -------------------------------
apply_config() {
    generate_config
    echo
    read -p "Apply NEOWAVE config? [y/N]: " confirm
    [[ "$confirm" != "y" ]] && echo "✖️ Apply cancelled" && return
    mv "$TMP_CONF" "$ACTIVE_CONF"
    echo "✔️ NEOWAVE config applied (custom ASCII + colors + info aligned!)"
}
