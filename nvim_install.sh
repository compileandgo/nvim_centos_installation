#!/usr/bin/env bash

# =============================================================================
# Neovim + NvChad installation script by compileandgo (Jayant Kushwaha)
# Only for CentOs 8 and 9 
# =============================================================================

# Dependency check (essential for Treesitter & Mason)
echo "installing build dependencies..."
sudo dnf install -y gcc-c++ make unzip git curl

# get the os version
echo "cheking os version..."
os_version=$(rpm -E '%{rhel}')

if [[ "$os_version" == "8" ]]; then
  echo "WARNING! You are running CentOS 8 --- fixing EOL repo mirros..."
  sudo sed -i 's/mirrorlist/#mirrorlist/g; s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/*.repo
  echo "EOL repo mirrors fixed, pointing to vault.centos.org"
elif [[ "$os_version" == "9" ]]; then
  echo "You are running CentOs 9, repos are fine --- skipping mirror fix..."
else
  echo "You are running older version of CentOS, this might not work on your system, proceeding anyway."
fi

# exit immediately on any error
set -e

# cleanup
echo "Cleaning old Neovim data..."
rm -rf ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.cache/nvim

# Download latest Neovim pre-build
echo "Downloading latest Neovim pre-build..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# remove existing folder
echo "Removing older installation..."
sudo rm -rf /opt/nvim-linux-x86_64

# extract Neovim to /opt
echo "Extractiing nvim to /opt..."
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# delete the .tar.gz
echo "Removing nvim-linux-x86_64.tar.gz..."
rm -f nvim-linux-x86_64.tar.gz

# adding Neovim to PATH (for persistant access)
nvim_path='export PATH="$PATH:/opt/nvim-linux-x86_64/bin"'

if ! grep -qF "$nvim_path" ~/.bashrc; then
  echo "$nvim_path" >> ~/.bashrc
  echo "path updated!"
else
  echo "path already exists. --- skipping..."
fi

# apply to current path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# verify installation
echo ""
echo "nvim location: $(which nvim)"
echo "nvim version: $(nvim --version | head -1)"

# clonning the NvChad repo in ~/.config
echo "Clonning the NvChad repo..."
git clone https://github.com/NvChad/starter ~/.config/nvim

echo ""
echo "============================================================"
echo "  ✅ Setup complete! Now run:  nvim"
echo "  NvChad will auto-install plugins on first launch."
echo "  When prompted by Mason, press ENTER to confirm."
echo "============================================================"
echo ""
echo "⚠️ IMPORTANT — Nerd Font required for icons:"
echo "   NvChad uses icons that need a Nerd Font installed"
echo "   in your terminal. Without it, you will see broken"
echo "   symbols (□ or ?)."
echo ""
echo "   Download a Nerd Font from: https://www.nerdfonts.com"
echo "   Recommended: JetBrainsMono Nerd Font or FiraCode Nerd Font"
echo "   Then set it as your terminal emulator's font."
echo "============================================================"

