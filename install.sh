#!/bin/bash

set -euxo pipefail

: Install Git
sudo apt install git -y

: Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

: Installing pip3 for sudo user
sudo su - <<EOF
apt install pip
EOF

: Install Kinto
/bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh || curl -fsSL https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh)"

: Install Spotify
sudo snap install spotify

: Install Tilix
sudo apt-get install tilix -y

: symlink virtual terminal emulator
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh

: Copy default Tilix config in
dconf load /com/gexperts/Tilix/ < zach-default.dconf

: Install 1Password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install 1password -y

: Install Steam
sudo add-apt-repository multiverse
sudo apt-get update -y
sudo apt-get install steam -y

: Install PulseEffects
sudo apt install pulseeffects -y

: Install PCSCD Needed for Yubico Authenticator
sudo apt install pcscd -y

: Install vim
sudo apt install vim -y

: Set 12 hour time format
gsettings set org.gnome.desktop.interface clock-format 12h

: Set dock favorites
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'sublime_text.desktop', 'com.gexperts.Tilix.desktop', '1password.desktop', 'spotify_spotify.desktop', 'com.github.wwmm.pulseeffects.desktop']"
