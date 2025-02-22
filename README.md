# Beautify Terminal Installation Script

## Objective

This script is designed to enhance and beautify your terminal experience on Debian-based systems (e.g., Ubuntu) by installing a few useful tools and a custom font:

- **bat**: A modern replacement for `cat` with syntax highlighting and Git integration.
- **lsd**: A stylish replacement for `ls`, offering advanced features and better output.
- **Hack Nerd Font**: A beautiful, patched font for developers, optimized for programming environments.

The goal of this script is to provide a better, more visually appealing terminal experience.

## Features

- Installs **bat** for improved file viewing.
- Installs **lsd** as a colorful and enhanced alternative to `ls`.
- Installs **Hack Nerd Font** for a better and more readable terminal font.
- Configures custom aliases for easier terminal usage.

## Prerequisites

Before running the script, ensure that you have `wget` and `dpkg` installed on your system. These tools are usually pre-installed on most Debian-based distributions.

## Installation

Follow these steps to install and configure everything:

### Step 1: clone the repository
```
git clone https://github.com/velfin13/beautify_terminal.git
```

### Step 2: give it execution permissions
```
cd beautify_terminal
sudo chmod +x beautify_terminal.sh
```

### Step 3: run it
```
./beautify_terminal.sh
```