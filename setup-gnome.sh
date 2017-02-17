#! /bin/sh

#
# Remove unnecessary applications in Gnome
# Install some useful applications
# Setup Gnome Shell desktop
#

# Remove unwanted applications
apt purge evolution empathy cheese gnome-maps gnome-mahjongg gnome-games \
gnome-sudoku gnome-tetravex gnome-chess gnome-dictionary gnome-orca polari \
transmission-common simple-scan rhythmbox rhythmbox-data gnome-clocks \
hamster-applet gnome-photos gnome-music totem-common gnome-getting-started-docs \
gnome-sound-recorder gnome-user-guide gnome-contacts gnome-documents gnome-mines \
gnome-klotski gnome-robots gnome-nibbles aisleriot five-or-more four-in-a-row \
iagno quadrapassel hitori swell-foop tali xboard lightsoff gnome-packagekit-data \
gnome-font-viewer gnome-logs gnome-disk-utility gnome-shell-extension-weather \
bijiben tracker reportbug gnome-nettool yelp baobab gnome-system-log seahorse \
gnome-online-miners gnome-accessibility-themes dconf-editor avahi-daemon \
gnome-color-manager gnome-online-accounts caribou rygel zeitgeist-core

# Remove orphan packages (three times)
deborphan | sudo xargs apt purge -y
deborphan | sudo xargs apt purge -y
deborphan | sudo xargs apt purge -y

# Fix meta-package dependencies
aptitude update

# Install useful applications
apt install -y gip wireshark ttf-mscorefonts-installer flashplugin-nonfree \
geany gparted vlc virtualbox numlockx firefox-esr firefox-esr-l10n-fr

# Add desktop file with mime info for Packet Tracer, Firefox, and Thunderbird
cp config/*.desktop /usr/share/applications/
update-desktop-database

# Configure font rendering
ln -sf /usr/share/fontconfig/conf.avail/10-autohint.conf /etc/fonts/conf.d/
ln -sf /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

# Setup default background
update-alternatives --set desktop-grub /usr/share/images/desktop-base/joy-grub.png
update-alternatives --set desktop-background.xml /usr/share/images/desktop-base/joy.xml
update-alternatives --set desktop-background /usr/share/images/desktop-base/joy-wallpaper_1920x1200.svg
dpkg-reconfigure desktop-base

# Setup Gnome Shell
cp -fv config/gnome.conf /usr/share/glib-2.0/schemas/20_desktop-base.gschema.override
glib-compile-schemas /usr/share/glib-2.0/schemas

# Download and install Atom
wget -O /tmp/atom.deb https://atom.io/download/deb
dpkg -i /tmp/atom.deb

# Add function to bashrc to update Atom
cat config/update-atom.sh >> /etc/bash.bashrc

# Download and install Google Chrome
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i /tmp/chrome.deb

# Add function to bashrc to update Google Chrome
cat config/update-chrome.sh >> /etc/bash.bashrc
