#!/usr/bin/bash

set -e  # Exit on error

echo "Removing snap..."

# Stop the snapd service and disable it
echo "Disabling snapd..."
sudo systemctl disable --now snapd.socket || true
sudo systemctl disable --now snapd || true

# Uninstall snapd package
echo "Purging snapd..."
sudo apt purge -y --allow-downgrades snapd

# Clean up snap-related directories
echo "Removing snap-related directories..."
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd ~/snap || true

# Prevent snapd from being reinstalled in the future
echo "Configuring apt to block snapd..."
cat << EOF | sudo tee /etc/apt/preferences.d/no-snap.pref > /dev/null
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

# Ensure proper ownership for the preferences file
sudo chown root:root /etc/apt/preferences.d/no-snap.pref

echo "Snap has been successfully removed."
