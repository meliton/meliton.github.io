#!/usr/bin/env bash
# WD My Cloud Installer
# by Meliton Hinojosa
# Install programs to your WD MyCLoud
#
#
# Install with this command (from your WD My Cloud):
#
# curl -L meliton.github.io\testinstall.sh | bash

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

welcomeDialog()
{
# Display the welcome dialog message
whiptail --title "WD My Cloud Automated Installer" --msgbox "This installer will allow you to add features to your My Cloud NAS

Every reasonable measure has been taken in these scripts to ensure a safe and minimally intrusive mod." $r $c

# Inform about voiding the warranty
whiptail --title "WARNING - MAY VOID YOUR WARRANTY" --msgbox "According to WD's support site...

The use of SSH (Secure Shell) to tamper with the drive in order to modify or attempt to modify the device outside the normal operation of the product will void the drive's warranty." $r $c

whiptail --title "WARNING - MAY VOID YOUR WARRANTY" --msgbox "THIS SOFTWARE IS PROVIDED 'AS IS' WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  

IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OT THE USE OR OTHER DEALINGS WITH THE SOFTWARE." $r $c 

if (whiptail --title "Accept License Agreement?" --yesno "Do you accept the terms?"  $r $c) then
  echo 
else 
    echo "User selected NO - cancelling script" ; exit 1
fi
}

getUserStatus()
{
# Checks if user is root
case "$EUID" in
    0) ;;
    *) whiptail --title 'Not Root User' --infobox 'Installation must be run as ROOT user' $r $c ; exit 1 ;;
esac 
}

#getcloudSpecs()
#{
# Notice to gather My Cloud specs
#whiptail --title "Verifying Device" --msgbox "We will first check that you are running this script on a compatible device." $r $c
#}

########## SCRIPT ##########
# get screen info to render properly
getRowColumn

# Welcome screen
welcomeDialog

# get user status
getUserStatus

# get the hardware specs
#getCloudSpecs


echo ; echo ; echo This is a sample installer
echo ; echo ; echo The end.

