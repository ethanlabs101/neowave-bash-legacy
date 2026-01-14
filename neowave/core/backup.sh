#!/usr/bin/env bash

NEOFETCH_DIR="$HOME/.config/neofetch"
NEOFETCH_CONF="$NEOFETCH_DIR/config.conf"
NEOFETCH_ORIG="$NEOFETCH_DIR/config.conf.original"
TMP_CONF="$HOME/.config/neowave/core/tmp.conf"
STOCK_URL="https://gist.githubusercontent.com/Jaid/dbac30d9a9e810e0dc445c8694cbff84/raw"
STOCK_CONFIG="$HOME/.config/neowave/stock_configs/config.conf"

mkdir -p "$HOME/.config/neowave/stock_configs"

ensure_neofetch_exists() {
    if [[ ! -f "$NEOFETCH_CONF" ]]; then
        echo "✖️ Neofetch config not found."
        echo "Run neofetch once before using NEOWAVE."
        return 1
    fi
    return 0
}

download_stock_config() {
    echo "⬇️ Downloading upstream stock config..."
    wget -q -O "$STOCK_CONFIG" "$STOCK_URL" || {
        echo "✖️ Failed to download stock config!"
        return 1
    }
    echo "✔️ Stock config downloaded"
}

backup_original_config() {
    ensure_neofetch_exists || return

    # Download stock config if missing
    [[ ! -f "$STOCK_CONFIG" ]] && download_stock_config

    if [[ ! -f "$NEOFETCH_ORIG" ]]; then
        cp "$STOCK_CONFIG" "$NEOFETCH_ORIG"
        echo "✔️ Original stock config backed up"
    fi
}

restore_original_config() {
    # Make sure stock config exists
    [[ ! -f "$STOCK_CONFIG" ]] && download_stock_config

    if [[ -f "$NEOFETCH_ORIG" ]]; then
        read -p "Restore original Neofetch config? [y/N]: " confirm
        [[ "$confirm" != "y" ]] && return

        # Restore neofetch config
        cp "$STOCK_CONFIG" "$NEOFETCH_CONF"

        # ALSO reset NEOWAVE session tmp config
        cp "$STOCK_CONFIG" "$TMP_CONF"

        echo "✔️ Original stock config restored and session reset"
    else
        echo "✖️ No original backup found"
    fi
}
