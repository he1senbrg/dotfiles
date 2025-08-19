#!/usr/bin/env bash

set -e

DOTFILES_DIR=$(pwd)

CONFIG_DIRS=(
    "niri"
    "rofi"
    "waybar"
)

PACMAN_PKGS=(
    alacritty
    amd-ucode
    base
    base-devel
    blueman
    bluez
    bluez-utils
    brightnessctl
    btrfs-progs
    chromium
    distrobox
    docker
    dosfstools
    efibootmgr
    fastfetch
    firefox
    fuzzel
    git
    github-cli
    gnome-calculator
    gparted
    grub
    gst-plugin-pipewire
    gtk-engine-murrine
    htop
    iwd
    jre21-openjdk-headless
    just
    libpulse
    linux
    linux-firmware
    mako
    mtools
    nano
    network-manager-applet
    networkmanager
    niri
    noto-fonts-emoji
    nwg-look
    os-prober
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
    postgresql
    python-pipx
    qt5-tools
    qt5-wayland
    rofi-wayland
    sassc
    sddm
    smartmontools
    sof-firmware
    swaybg
    swayidle
    swaylock
    swaync
    swayosd
    swww
    thunar
    ttf-firacode-nerd
    vim
    vulkan-radeon
    waybar
    wget
    wireless_tools
    wireplumber
    wl-clipboard
    xdg-desktop-portal-gnome
    xdg-utils
    xf86-video-amdgpu
    xf86-video-ati
    xorg-server
    xorg-xinit
    xorg-xwayland
    zram-generator
    zsh
    hyprpicker
    qbittorrent
    qt5-wayland 
    qt6-wayland
    dnsmasq
    polkit
    mate-polkit
    qemu-full
    libvirt
    virt-manager
    xorg-xwayland
    xorg-xhost
    xwayland-satellite
    vi
    picocom
    btop
)

YAY_PKGS=(
    bibata-cursor-theme
    clipse
    vesktop
    visual-studio-code-bin
    waypaper
    youtube-music-bin
)

echo "==> Creating symlinks for config directories..."
mkdir -p "$HOME/.config"
for dir in "${CONFIG_DIRS[@]}"; do
    src="$DOTFILES_DIR/$dir"
    dest="$HOME/.config/$dir"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing $dest to $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    ln -s "$src" "$dest"
    echo "Linked $src → $dest"
done

ln -s "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "==> Installing pacman packages..."
sudo pacman -Syu --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "==> Checking for yay..."
if ! command -v yay &>/dev/null; then
    echo "yay not found, installing..."
    sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
else
    echo "yay already installed."
fi

echo "==> Installing yay packages..."
yay -S --needed --noconfirm "${YAY_PKGS[@]}"

echo "==> Setup complete!"
