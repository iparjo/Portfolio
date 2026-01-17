#!/bin/bash
# Pop!_OS 24.04 - Post-install script and configuration
# Created by iparjo on Github

# Update and upgrade the system
sudo apt -y update && sudo apt -y full-upgrade

echo "------"

# Check if the Wallpapers directory exists, if that's the case
# a message will tell that the wallpaper is already downloaded, otherwise download it
if [[ $HOME/Pictures/Wallpapers == false ]]; then
    mkdir $HOME/Pictures/Wallpapers
    wget https://i.redd.it/b76jlqhxltze1.png -O $HOME/Pictures/Wallpapers/island.png
else
    echo "The wallpaper is already downloaded."
fi

echo "------"

# Check if the button has been configured on the interface, if that's the case
# a message will tell that the icon is already configured, otherwise configure it
if [[ $HOME/.config/cosmic/com.system76.CosmicPanelButton/v1/configs == false ]]; then
    echo "{" > $HOME/.config/cosmic/com.system76.CosmicPanelButton/v1/configs 
    echo "    \"Panel\": (force_presentation: Some(Icon))" >> $HOME/.config/cosmic/com.system76.CosmicPanelButton/v1/configs
    echo "}" >> $HOME/.config/cosmic/com.system76.CosmicPanelButton/v1/configs
else
    echo "The icon is already configured."
fi

echo "------"

# Create a variable with the value of the command hostname
host=$(hostname)

# Check if the hostname is the default one, if not send a message about it
# otherwise tell the user to select the new name for the host
if [[ host != "pop-os" ]]; then
    echo "It's not necessary to rename the host."
else
    echo "Select the name of the host:"
    read name_of_the_host
    hostnamectl hostname ${name_of_the_host} 
    echo "The name of the host has been changed."
fi
