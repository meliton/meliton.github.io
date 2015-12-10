#!/usr/bin/env bash
# pfSense Login Script
# by Meliton Hinojosa
#
# Log into pfSense
#
# curl -L meliton.github.io\loginsense.sh | bash

########## VARIABLES ##########
# put vars here


########## FUNCTIONS ##########
getRowColumn()
{
# Find rows and columns
rows=$(stty -a | tr \; \\012 | grep 'rows' | cut -d' ' -f3)
columns=$(stty -a | tr \; \\012 | grep 'columns' | cut -d' ' -f3)

# Divide by two so the dialogs take up half of the screen
r=$(( rows / 2 ))
c=$(( columns / 2 ))
}

loginDialog()
{
# display the login dialog

USER=$(whiptail --inputbox "Enter your user name" $r $c --title "pfSense Login Screen" 3>&1 1>&2 2>&3)
exitstatus=$?

PASSWORD=$(whiptail --passwordbox "Enter your password" $r $c --title "pfSense Login Screen" 3>&1 1>&2 2>&3)
exitstatus=$?

curl --connect-timeout 5 --data "auth_user=$varUser&auth_pass=$varPass&accept=Continue" http://192.168.1.1:8002
}

########## SCRIPT ##########
# get screen info to render properly
getRowColumn

# login screen
loginDialog
