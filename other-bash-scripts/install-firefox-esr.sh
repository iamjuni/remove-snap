#!/usr/bin/bash

echo "Adding mozilla ppa"

sudo add-apt-repository ppa:mozillateam/ppa

sudo apt-get -y update

echo "Configuring apt to block snap version of firefox"

cat << EOF | sudo tee /etc/apt/preferences.d/firefox.pref > /dev/null
Package: firefox
Pin: version 1:1snap*
Pin-Priority: -5
EOF

echo "Removing snap version of firefox"

sudo snap remove firefox || true

echo "Installing firefox"

sudo apt-get install -y firefox-esr
