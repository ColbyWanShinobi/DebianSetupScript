#!/bin/bash

# KDE Plasma 6 Tweaking Script
# Equivalent of tweak-gnome.sh for KDE Plasma 6
# 
# NOTE: This script assumes Apple fonts (SF Pro Display, SF Mono, Apple Color Emoji) 
# are already installed. Run the font installation commands from install-apple-fonts.sh first:
# - Apple Color Emoji from: https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf
# - SF Fonts from: https://github.com/aishalih/sfwin.git

# Function to safely run kwriteconfig commands
safe_kwriteconfig() {
    kwriteconfig6 "$@" 2>/dev/null || kwriteconfig5 "$@" 2>/dev/null || true
}

echo "Applying KDE Plasma 6 tweaks..."

# Use dark theme
safe_kwriteconfig --file kdeglobals --group General --key ColorScheme "BreezeDark"
safe_kwriteconfig --file plasmarc --group Theme --key name "breeze-dark"

# Always show thumbnail previews in Dolphin
safe_kwriteconfig --file dolphinrc --group "PreviewSettings" --key "Plugins" "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,textthumbnail,ffmpegthumbnail"

# Set locale to US (imperial units)
safe_kwriteconfig --file kdeglobals --group Locale --key Measurement "1" # 1 = Imperial, 0 = Metric

# Enable window control buttons (close, minimize, maximize) and move to left like macOS
# X = close, N = minimize, A = maximize, M = menu
safe_kwriteconfig --file kwinrc --group "org.kde.kdecoration2" --key "ButtonsOnLeft" "XNA"
safe_kwriteconfig --file kwinrc --group "org.kde.kdecoration2" --key "ButtonsOnRight" ""

# Change touchpad scroll direction (disable natural scroll)
# Note: Touchpad device path may vary - this is a generic approach
safe_kwriteconfig --file touchpadxlibinputrc --group "Libinput" --key "NaturalScroll" "false"

# Set the number of virtual desktops to one
safe_kwriteconfig --file kwinrc --group Desktops --key Number "1"

# Disable screen edges (equivalent to hot corners)
safe_kwriteconfig --file kwinrc --group ScreenEdges --key "Left" "None"
safe_kwriteconfig --file kwinrc --group ScreenEdges --key "Right" "None"
safe_kwriteconfig --file kwinrc --group ScreenEdges --key "Top" "None"
safe_kwriteconfig --file kwinrc --group ScreenEdges --key "Bottom" "None"

# Power management - never sleep on AC power
safe_kwriteconfig --file powermanagementprofilesrc --group "AC" --group "SuspendSession" --key "idleTime" "0"
safe_kwriteconfig --file powermanagementprofilesrc --group "AC" --group "SuspendSession" --key "suspendType" "0"

# Touchpad settings (generic approach for better compatibility)
safe_kwriteconfig --file touchpadxlibinputrc --group "Libinput" --key "ClickMethod" "2" # 2 = Click with fingers
safe_kwriteconfig --file touchpadxlibinputrc --group "Libinput" --key "TapToClick" "true"
safe_kwriteconfig --file touchpadxlibinputrc --group "Libinput" --key "ScrollMethod" "2" # 2 = Two finger scrolling
safe_kwriteconfig --file touchpadxlibinputrc --group "Libinput" --key "NaturalScroll" "false"

# Enable window tiling
safe_kwriteconfig --file kwinrc --group Windows --key "ElectricBorderTiling" "true"
safe_kwriteconfig --file kwinrc --group Windows --key "ElectricBorderMaximize" "true"

# Disable dynamic workspaces (use fixed number)
safe_kwriteconfig --file kwinrc --group Desktops --key Number "1"

# Terminal settings (Konsole)
safe_kwriteconfig --file konsolerc --group "Desktop Entry" --key "DefaultProfile" "default.profile"
safe_kwriteconfig --file konsole/default.profile --group General --key "Environment" "TERM=xterm-256color"

# Default Konsole size
safe_kwriteconfig --file konsolerc --group "MainWindow" --key "width" "1920"
safe_kwriteconfig --file konsolerc --group "MainWindow" --key "height" "1080"

# Enable experimental features (variable refresh rate, etc.)
safe_kwriteconfig --file kwinrc --group Compositing --key "LatencyPolicy" "Low"
safe_kwriteconfig --file kwinrc --group Compositing --key "RenderTimeEstimator" "1"

# File chooser - show hidden files
safe_kwriteconfig --file kdeglobals --group KFileDialog --key "ShowHidden" "true"

# Apple Fonts Configuration (equivalent to install-apple-fonts.sh settings)
# Set SF Pro Display as the default system font
safe_kwriteconfig --file kdeglobals --group General --key "font" "SF Pro Display,11,-1,5,50,0,0,0,0,0"

# Set SF Mono as the monospace font
safe_kwriteconfig --file kdeglobals --group General --key "fixed" "SF Mono,13,-1,5,50,0,0,0,0,0"

# Set SF Pro Display for small font (equivalent to document font)
safe_kwriteconfig --file kdeglobals --group General --key "smallestReadableFont" "SF Pro Display,8,-1,5,50,0,0,0,0,0"

# Set SF Pro Display Bold for window titles
safe_kwriteconfig --file kdeglobals --group WM --key "activeFont" "SF Pro Display,11,-1,5,75,0,0,0,0,0"

# Set desktop/menu font
safe_kwriteconfig --file kdeglobals --group General --key "menuFont" "SF Pro Display,11,-1,5,50,0,0,0,0,0"

# Set toolbar font
safe_kwriteconfig --file kdeglobals --group General --key "toolBarFont" "SF Pro Display,11,-1,5,50,0,0,0,0,0"

# Note: Panel and widget configurations are commented out as they can cause kicker errors
# These settings are better configured manually through System Settings
# For panel position, taskbar behavior, and widgets:
# Go to System Settings > Workspace Behavior > Panel Behavior

# Apply all changes
# Use plasma-apply-* commands for better compatibility with Plasma 6
plasma-apply-colorscheme BreezeDark 2>/dev/null || true
plasma-apply-desktoptheme breeze-dark 2>/dev/null || true

# Restart plasmashell to apply changes
echo "Restarting plasmashell to apply changes..."
kquitapp6 plasmashell 2>/dev/null || kquitapp5 plasmashell 2>/dev/null || killall plasmashell 2>/dev/null || true
sleep 2
plasmashell --replace &
disown

echo "KDE Plasma 6 tweaks applied. You may need to log out and back in for all changes to take effect."
echo "Note: Some settings may require a full logout/login to take effect properly."
