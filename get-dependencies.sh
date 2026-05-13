#!/bin/sh

set -eu

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
sudo pacman -Syy --noconfirm archlinux-keyring
#Build
sudo pacman -S --noconfirm --needed git meson blueprint-compiler
#Needed
sudo pacman -S --noconfirm --needed python python-gobject python-cairo gtk4 glycin-gtk4 libadwaita ffmpeg 
#Optional
sudo pacman -S --noconfirm --needed libva-utils
    
echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Installing constrict from source packages..."
echo "---------------------------------------------------------------"
git clone https://gitlab.gnome.org/World/Constrict.git source
cd source
meson setup build --prefix=/usr
meson compile -C build
sudo meson install -C build
cd ..

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
