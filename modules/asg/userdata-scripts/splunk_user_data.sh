#!/bin/bash

# Variables
SPLUNK_VERSION="9.3.1"  # Replace with the desired Splunk version
SPLUNK_DEB="splunk-${SPLUNK_VERSION}-0b8d769cb912-linux-2.6-amd64.deb"
SPLUNK_URL="https://download.splunk.com/products/splunk/releases/${SPLUNK_VERSION}/linux/${SPLUNK_DEB}"
INSTALL_DIR="/opt/splunk"
ADMIN_USER="admin"
ADMIN_PASS="123456789"  # Set the admin password

SPLUNK_HOME="$INSTALL_DIR"

# Update the system
sudo apt-get update -y

# Download Splunk
wget -O $SPLUNK_DEB $SPLUNK_URL

# Install Splunk
sudo dpkg -i $SPLUNK_DEB

# Predefine admin user with user-seed.conf
sudo mkdir -p $INSTALL_DIR/etc/system/local
sudo bash -c "cat <<EOL > $INSTALL_DIR/etc/system/local/user-seed.conf
[user_info]
USERNAME = $ADMIN_USER
PASSWORD = $ADMIN_PASS
EOL"

# Accept License Agreement and Start Splunk (non-interactively)
sudo $INSTALL_DIR/bin/splunk start --accept-license --answer-yes --no-prompt

# Enable Splunk to start on boot
sudo $INSTALL_DIR/bin/splunk enable boot-start --answer-yes --no-prompt

# Start Splunk
sudo $INSTALL_DIR/bin/splunk start

# Clean up the downloaded .deb file
rm $SPLUNK_DEB

echo "Splunk installation and admin user setup completed."

ufw allow 8000/tcp    # Splunk web interface
ufw allow 8000/udp    # web interface
ufw allow 9997/tcp    # Splunk indexer
ufw allow 9997/udp    # web interface for splunk
ufw allow 8089/tcp    # Splunk forwarder
ufw allow 8089/udp    # web interface for splunk forwarder
ufw reload