#!/usr/bin/env bash
# pfSense Login Script
# by Meliton Hinojosa
#
# Log into pfSense
#
# curl meliton.github.io\loginsense.sh | bash

########## FUNCTIONS ##########
getRowColumn()
{
# Find rows and columns
rows=$(tput lines)
columns=$(tput cols)

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

curl --connect-timeout 5 --data "auth_user=$USER&auth_pass=$PASSWORD&accept=Continue" http://192.168.1.1:8002
}

########## SCRIPT ##########
# get screen info to render properly
getRowColumn

# login screen
loginDialog
