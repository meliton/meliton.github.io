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
whiptail --title "WD My Cloud Automated Installer" --msgbox "This installer will allow you to add features to your WD My Cloud NAS Server.

Supported versions with Firmware 4.04.01-112 (10/21/2015)
- WD My Cloud WDBCTL0020HWT NAS Server 2 TB
- WD My Cloud WDBCTL0030HWT NAS Server 3 TB
- WD My Cloud WDBCTL0040HWT NAS Server 4 TB
- WD My Cloud WDBCTL0060HWT NAS Server 6 TB

Every reasonable measure has been taken to ensure a safe and minimally intrusive mod." $r $c

# Inform about voiding the warranty
whiptail --title "WARNING - MAY VOID YOUR WARRANTY" --msgbox "NOTICE: According to WD's support site...

The use of SSH (Secure Shell) to tamper with the drive in order to modify or attempt to modify the device outside the normal operation of the product will void the drive's warranty." $r $c

whiptail --title "WARNING - MAY VOID YOUR WARRANTY" --msgbox "THIS SOFTWARE IS PROVIDED 'AS IS' WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  

IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE To THE USE OR OTHER DEALINGS WITH THE SOFTWARE." $r $c 

if (whiptail --title "Accept License Agreement?" --yesno "Do you accept the terms?"  $r $c) then
  echo 
else 
    echo "Exiting... user selected NO - cancelling the script" ; exit 1
fi
}

getUserStatus()
{
# Checks if user is root
case "$EUID" in
    0) ;;
    *) echo Exiting... Installation must be run as ROOT user ; exit 1 ;;
esac 
}

getCloudSpecs()
{
# Notice to gather My Cloud specs
whiptail --title "Verifying Device" --msgbox "First, we will check that you are running this on a compatible device." $r $c

# check for armv7l hardware (use x86 to test in vm)
case "$(uname -m 2>/dev/null | grep -c "armv7l" )" in
   1) ;;
   *) echo Exiting... Wrong hardware type. Not armv7l ; exit 1 ;;
esac

# check for firmware version 04.0x.xx
case "$(head /etc/version 2>/dev/null | grep -c "04.0" )" in
   1) ;;
   *) echo Exiting... Wrong Firmware. Not 04.xx.xx ; exit 1 ;;
esac
whiptail --title "Success" --msgbox "You are running this on a compatible WD My Cloud NAS." $r $c 
}

checkManBug()
{
if (whiptail --title "Bug Check" --yesno "Do you want to check for and fix the man folder permission bug?

Leaving this bug in place will not allow man pages for the packages you install.

It's highly recommended to check for (YES) and fix this bug." $r $c ) then

# check for man folder permission bug
case "$(ls -l /var/cache/ 2>/dev/null | grep "man" | cut -f 3 -d ' ' )" in
   man) ;;
   *) echo Man folder bug found. Fixing man folder ; echo chown -R man:root /var/cache/man ;; 
esac ; 
else echo Skipping... man bug check
fi
}

softwareMenuList()
{
# put a list of the software packages you support
whiptail --title "Software Installation List"  --checklist \
"Choose the software you want to install." 15 60 6 \
"htop" "interactive process viewer" ON \
"git" "version control system" OFF \
"unrar" "unarchiver for .rar files" OFF \
"SickRage" "TV show downloader" OFF \
"SickBeard" "Movie downloader" OFF \
"Transmission" "bittorrent client" OFF 
}


########## SCRIPT ##########
# get screen info to render properly
getRowColumn

# Welcome screen
welcomeDialog

# get user status
getUserStatus

# get the hardware specs
getCloudSpecs

# check for the man bug
checkManBug

# show the software menu
softwareMenuList


echo ; echo ; echo Success!  The end.
