#!/usr/bin/env bash
# KMS on pfSense Installer
# by Meliton Hinojosa
# Install KMS server on your pfSense appliance
#
#
# Install with this command (from your pfSense appliance):
#
# curl -L meliton.github.io/kms2pfsense.sh | sh
getPFspecs()
{
# Notice to gather specs
echo "First, we will check that you are running this on a compatible device."

# check for FreeBSD OS
case "$(uname -s 2>/dev/null | grep -c "FreeBSD" )" in
   1) echo "Running on FreeBSD" ;;
   *) echo "Wrong OS type, not FreeBSD." ; 
   exit 1 ;;
esac

# check for amd64 hardware
case "$(uname -m 2>/dev/null | grep -c "amd-64" )" in
   1) ;;
   *) echo "Wrong Hardware Type, not amd64." ; 
   exit 1 ;;
esac

# check for OS version 11.xx or higher
case "$(uname -r 2>/dev/null | grep -c "11." )" in
   1) ;;
   *) echo "Wrong OS version. Not at least 11.xx" ; 
   exit 1 ;;
esac

echo "Success .You are running this on a compatible pfSense appliance." 
}


# get the hardware specs
getPFspecs
