#!/bin/bash

# Copy the udev rules file
sudo cp ./etc/udev/rules.d/42-logitech-unify-permissions.rules /etc/udev/rules.d/


# Reboot the system
#echo "Rebooting the system to apply changes..."
#sudo reboot
