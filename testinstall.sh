#!/usr/bin/env bash
# WD My Cloud Installer
# by Meliton Hinojosa
# Install programs to your WD MyCLoud
#
#
# Install with this command (from your WD My Cloud):
#
# curl -L meliton.github.io\testinstall.sh | bash

# Find rows and columns
rows=$(stty -a | tr \; \\012 | grep 'rows' | cut -d' ' -f3)
columns=$(stty -a | tr \; \\012 | grep 'columns' | cut -d' ' -f3)

# Divide by two so the dialogs take up half of the screen
r=$(( rows / 2 ))
c=$(( columns / 2 ))


# Display the welcome dialog message
whiptail --backtitle "Welcome" --title "WD My Cloud Automated Installer" --msgbox "This installer will allow you to add features to your My Cloud NAS" $r $c

# Inform about device specs
whiptail --backtitle "Checking Device Specs" --title "Verifying Device" --msgbox "We will first check that you are running on a compatible device" $r $c


echo ; echo ; echo This is a sample installer
echo ; echo ; echo The end.
