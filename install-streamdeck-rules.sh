#!/bin/bash

# Copy the udev rules file
sudo cp ./etc/udev/rules.d/99-streamdeck.rules /etc/udev/rules.d/

# Reload the rules
echo "Reloading the rules..."
sudo udevadm control --reload-rules
