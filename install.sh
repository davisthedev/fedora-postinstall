#!/bin/bash

# Check if running as root
if [[ $UID -ne 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo "Starting installation..."
cd /home/davis

dnf update -y

dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf groupupdate core

dnf -y update
dnf -y upgrade --refresh

dnf install git kitty neovim stow python3-pip fd-find fzf ripgrep make gcc gnome-tweaks -y

dnf install gnome-extensions golang zsh -y

# NVIDIA
if lspci | grep -i nvidia > /dev/null; then
    echo "NVIDIA GPU is present."
    dnf install akmod-nvidia
    dnf install xorg-x11-drv-nvidia-cuda
fi

dnf copr enable atim/lazygit -y

systemctl disable NetworkManager-wait-online.service

rm /etc/xdg/autostart/org.gnome.Software.desktop

dnf install Discord Obsidian lazygit -y

echo "Installation complete."
