#!/bin/bash

# Copy the udev rules file
sudo cp ./etc/udev/rules.d/42-logitech-unify-permissions.rules /etc/udev/rules.d/
sudo groupadd -f plugdev
sudo usermod -a -G plugdev ${USER}

# Reload the rules
echo "Reloading the rules..."
sudo udevadm control --reload-rules
