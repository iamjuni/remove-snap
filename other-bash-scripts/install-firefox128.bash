#!/usr/bin/bash

echo "Adding mozilla ppa"

sudo add-apt-repository ppa:mozillateam/ppa

echo "Configuring apt to block snap's version of firefox"

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap*
Pin-Priority: -5
' | sudo tee /etc/apt/preferences.d/mozilla-firefox > /dev/null

echo "Removing snap version of firefox"

sudo snap remove firefox || true

echo "Installing firefox"

sudo apt-get -y firefox
