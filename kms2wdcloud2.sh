#!/usr/bin/env bash
# KMS-on-WDCloud v2 Installer
# by Meliton Hinojosa
# Installer for KMS server on your WD Cloud 2 appliance
#
# Install with this command (from your WD Cloud 2 appliance):
#
# You'll need to install curl for this to work
#
# curl -L meliton.github.io/kms2wdcloud2.sh | sh

getWDspecs()
{
# Notice to gather specs
echo 
echo "======= CHECKING for compatible device"

# check for Vanilla Linux
case "$(uname -s 2>/dev/null | grep -c "Linux" )" in
   1) echo " PASSED - Running on Linux" ;;
   *) echo " FAILED - Wrong OS type, not Linux" ; 
   exit 1 ;;
esac

# check for node hostname of wdmc
case "$(uname -n 2>/dev/null | grep -c "wdmc" )" in
   1) echo " PASSED - Running on wdmc" ;;
   *) echo " FAILED - Wrong node hostname type, not wdmc" ; 
   exit 1 ;;
esac

# check for amd64 hardware
case "$(uname -m 2>/dev/null | grep -c "armv7l" )" in
   1) echo " PASSED - Hardware platform is armv7l" ;;
   *) echo " FAILED - Wrong Hardware type, not armv7l" ; 
   exit 1 ;;
esac

# check for OS version 3.1.xx or higher
case "$(uname -r 2>/dev/null | grep -c "3.1" )" in
   1) echo " PASSED - Operating system 3.1 or higher" ;;
   *) echo " FAILED - Wrong OS version. Not at least 3.1" ; 
   exit 1 ;;
esac


echo " SUCCESS! You are running a compatible WD Cloud appliance" 
}

getUserStatus()
{
# Checks if user is root
echo "First we will check if you are running as root"
case "$(id -u | grep -c "0")" in
    1) echo " PASSED - Running as root" ;;
    *) echo " FAILED - Installation must be run as ROOT user" ; 
    exit 1 ;;
esac 
}

copyKMS()
{
echo " "
echo "======= COPYING KMS binary"
echo " COPYING KMS server to /bin directory"
curl -k -o /bin/vlmcsd -sS https://raw.githubusercontent.com/meliton/KMS-on-WDCloud/master/bin/vlmcsd
}

createStartup()
{
echo " "
echo "======= WRITING startup script"
echo " WRITING startup script as /usr/local/etc/rc.d/kms_start.sh"
echo "#!/bin/sh" > /etc/init.d/kms_start.sh
echo "#" >> /etc/init.d/kms_start.sh
echo "# startup script on bootup for KMS server" >> /etc/init.d/kms_start.sh
echo "# 30 day renewal, 7 day failed retry interval" >> /etc/init.d/kms_start.sh
echo "#" >> /etc/init.d/kms_start.sh
echo "/bin/vlmcsd -R30d -A7d" >> /etc/init.d/kms_start.sh
}

makeExecute()
{
echo " "
echo "======= SETTING executable flags on files"
echo " SETTING KMS binary executable"
chmod 755 /bin/vlmcsd
echo " SETTING kms_start script executable"
chmod 755 /etc/init.d/kms_start.sh
echo " CHECKING KMS binary and kms_start script for execute permissions"
ls -l /bin/vlmcsd | cut -d" " -f1,13
ls -l /etc/init.d/kms_start.sh | cut -d" " -f1,13
}

preCleanUp()
{
# clean-up old files
echo " "
echo "======= CLEANING up old files"
echo " KILLING KMS server..."
pkill vlmcsd
echo " DELETING old KMS server..."
rm -f /bin/vlmcsd
echo " DELETING old kms_start script..."
rm -f /etc/init.d/kms_start.sh
}

runKMS()
{
# run KMS server
echo " "
echo "======= STARTING KMS server on port 1688"
vlmcsd -R30d -A7d
netstat -an | grep 1688
}

#get the user status
#getUserStatus

# get the hardware specs
getWDspecs

# clean-up old files
preCleanUp

# copy the KMS server to /bin 
copyKMS

# create startup script at /etc/init.d
createStartup

# make files executable
makeExecute

# run KMS server
runKMS
