#!/bin/sh

if [ ! -n "$(pacman -Qs pacaur)" ]; then
    echo "Installing pacaur from the AUR..."
    sudo rm -rf /tmp/pacaur_install
    mkdir -p /tmp/pacaur_install
    cd /tmp/pacaur_install
    curl -o PKGBUILD "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur"
    makepkg PKGBUILD --install --needed --noconfirm
    rm -r /tmp/pacaur_install
fi

echo "All set! You should now be ready to manage your system with Ansible."
echo "The first things you should do are: set up another user, delete the alarm user, and change the root password."
exit 0
