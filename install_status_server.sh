#!/bin/bash

# Download the installation script from GitHub
curl -s https://raw.githubusercontent.com/clevrthings/status-server/refs/heads/main/create_status_server.sh -o /tmp/start_status_server.sh

# Make the script executable
chmod +x /tmp/start_status_server.sh

# Run the installation script
sudo /tmp/start_status_server.sh