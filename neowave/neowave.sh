#!/usr/bin/env bash
2
# ==============================
# NEOWAVE — Neofetch Orchestrator
# ==============================

NEOWAVE_DIR="$HOME/.config/neowave"
CORE_DIR="$NEOWAVE_DIR/core"

# Load core modules (when they exist)
for module in utils state backup apply logos actions menu; do
    [[ -f "$CORE_DIR/$module.sh" ]] && source "$CORE_DIR/$module.sh"
done

clear
neowave_banner
backup_original_config
main_menu
