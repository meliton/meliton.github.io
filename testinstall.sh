#!/usr/bin/env bash
# WD My Cloud Installer
# by Meliton Hinojosa
# Install programs to your WD MyCLoud
#
#
# Install with this command (from your WD My Cloud):
#
# curl -L meliton.github.io\testinstall.sh | bash


# Get the screen size in case we need a full-screen message and so we can display dialog that is sized the best
#screenSize=$(stty -a | tr \; \\012 | grep 'rows|columns' | cut '-d ' -f3)

# Find rows and columns
rows=$(stty -a | tr \; \\012 | grep 'rows' | cut -d' ' -f3)
columns=$(stty -a | tr \; \\012 | grep 'columns' | cut -d' ' -f3)

# Divide by two so the dialogs take up half of the screen, which looks nice.
r=$(( rows / 2 ))
c=$(( columns / 2 ))


# Display the welcome dialog message
whiptail --msgbox --backtitle "Welcome" --title "WD My Cloud Automated Installer" "This installer will allow you to add features to your My CLoud NAS" $r $c

# Inform about device specs
whiptail --msgbox --backtitle "Checking Device Specs" --title "We will first check that you are running on a compatible device" $r $c


echo ; echo ; echo This is a sample installer
echo ; echo ; echo The end.
