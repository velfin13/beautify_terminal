#!/bin/bash

###############################################
#                                             #
#        Installation of Packages and Fonts   #
#       to Beautify the Terminal              #
#                                             #
# Created by Velfin Velasquez                 #
# Email: velfinvelasquez@gmail.com            #
#                                             #
# Objective: This script's goal is to         #
# beautify your terminal, enhancing the user  #
# experience. It installs tools like 'bat'    #
# for better file viewing, 'lsd' as a stylish #
# replacement for 'ls', and the Hack Nerd     #
# Font to further personalize it.             #
#                                             #
# Enjoy your newly beautified terminal! 🎉    #
###############################################

# Package URLs
BAT_URL="https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb"
LSD_URL="https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd-musl_1.1.5_amd64.deb"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip"

# Directories
TMP_DIR="/tmp/install_debs"
FONT_TMP_DIR="/tmp/HackNerdFont"
FONT_DIR="/usr/share/fonts/HackNerdFont"

# Create temporary directories
mkdir -p "$TMP_DIR"
mkdir -p "$FONT_TMP_DIR"

# Download .deb files
echo "Downloading bat..."
wget -q --show-progress -O "$TMP_DIR/bat.deb" "$BAT_URL"

echo "Downloading lsd..."
wget -q --show-progress -O "$TMP_DIR/lsd.deb" "$LSD_URL"

# Download Hack Nerd Font
echo "Downloading Hack Nerd Font..."
wget -q --show-progress -O "$FONT_TMP_DIR/Hack.zip" "$FONT_URL"

# Install .deb packages
echo "Installing packages..."
sudo dpkg -i "$TMP_DIR/bat.deb" "$TMP_DIR/lsd.deb"

# Fix dependencies if needed
echo "Fixing missing dependencies..."
sudo apt-get install -f -y

# Check if Hack Nerd Font directory already exists
if [ ! -d "$FONT_DIR" ]; then
  # Install Hack Nerd Font
  echo "Installing Hack Nerd Font..."
  sudo mkdir -p "$FONT_DIR"
  sudo mv "$FONT_TMP_DIR/Hack.zip" "$FONT_DIR"
  cd "$FONT_DIR"
  sudo unzip -o Hack.zip
  sudo rm Hack.zip
else
  echo "Hack Nerd Font folder already exists. Skipping font installation."
fi

# Clean up font temporary files
echo "Cleaning up font temporary files..."
rm -rf "$FONT_TMP_DIR"

# Update font cache
echo "Updating font cache..."
sudo fc-cache -f -v

# Configure aliases in ~/.bashrc or ~/.zshrc
echo "Configuring aliases in the configuration file..."

if [[ $SHELL == *"zsh"* ]]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    CONFIG_FILE="$HOME/.bashrc"
fi

# Check if the aliases already exist before adding them
echo "Adding aliases to $CONFIG_FILE..."

# Add comment before the aliases
echo "# Custom Aliases" >> "$CONFIG_FILE"

# Aliases to add
ALIASES=(
  "alias ll='lsd -lh --group-dirs=first'"
  "alias la='lsd -a --group-dirs=first'"
  "alias l='lsd --group-dirs=first'"
  "alias lla='lsd -lha --group-dirs=first'"
  "alias ls='lsd --group-dirs=first'"
  "alias cat='bat'"
  "alias catn='/usr/bin/cat'"
  "alias catln='bat --paging=never'"
)

# Remove existing aliases if they are duplicates
for ALIAS in "${ALIASES[@]}"; do
  if grep -q "$ALIAS" "$CONFIG_FILE"; then
    echo "Alias already exists: $ALIAS"
    # Remove the previous line if exists
    sed -i "/$ALIAS/d" "$CONFIG_FILE"
  fi
  # Add the alias to the file
  echo "$ALIAS" >> "$CONFIG_FILE"
done

# Apply changes based on the shell
echo "Applying changes to the terminal..."
source "$CONFIG_FILE"

# Clean up downloaded files
echo "Cleaning up downloaded files..."
rm -rf "$TMP_DIR"

# Completion message
echo "Installation completed 🎉"
