## NeoWave Bash (Legacy) 🖤

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)

This is the original Bash version of NeoWave, my custom system info and terminal tool built around Neofetch. Consider this a legacy repo — it shows my early work and the foundation for the more advanced Lua version.

⚠️ Legacy Notice: Some features like custom ASCII logos and full color overrides don’t fully work in this version. For the latest and fully featured NeoWave, see the Lua version.

⸻

## 💻 Overview

NeoWave Bash was my first attempt at building a configurable, modular system info tool. It allowed:
 - Custom ASCII logos (limited in Bash)
 - Color presets for text and info modules
 - Right-aligned info modules
 - Preview, apply, and revert configs

It’s a lightweight approach to customizing Neofetch, designed to experiment with terminal aesthetics, info overrides, and system manipulation.

## 📂 File Structure & Description
- ├── apply.sh        # Main Bash script: generates temporary config, previews, applies, or reverts
- ├── ascii/          # Folder containing ASCII logos (legacy format)
- │   └── blackarch.ascii
- ├── colors/         # Color presets for terminal output
- ├── data/           # Distro info database (for ASCII selection)
- └── README.md       # You are here!

## 🚧 What Works
 - Right-aligned info modules
 - Config preview, apply, and revert system
 - Basic color customization from presets
 - Experimentation with distro ASCII logos

 ##  ⚠️ Limitations
 - Custom ASCII logos are broken or limited
 - Terminal background and full color override not implemented
 - No “fast fetch” mode support
 - Limited compatibility with modern terminal emulators (some features may not render correctly)

## 🏗️ The Ceiling Hit

This Bash version represents my early system experimentation. I pushed the boundaries of config-driven Neofetch manipulation, but Bash inherently limits:
 - Modular flexibility
 - Advanced ASCII/graphics handling
 - Full color and terminal modifications

This is why the Lua version was developed — to unlock full customization, module overrides, and proper ASCII/color support.

   ## 🔗 See Also
 - NeoWave Lua (Current Version) – Full-featured system info engine with custom ASCII, colors, modules, and overrides.

  ## 📜 License

This project is open source and released under the MIT License. See [![LICENSE](https://github.com/ethanlabs101/neowave-bash-legacy/blob/main/LICENSE)] for details.

“NeoWave Bash shows where I started — the first step toward building modular, powerful, and fun terminal tools.”
