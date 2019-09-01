#!/bin/bash
#
# zzzFan.sh Bash Script
# by Meliton Hinojosa
#
# Requires hddtemp program
#
#  HDD Temp      Fan Speed, HEX
#  0   - 100 F   25%, 19
#  101 - 120 F   50%, 32
#  121 - 130 F   75%, 4B
#  130 + F       90%, 5A
#
#  Set cronjob for this every 15 minutes as:
#  */15 * * * * /root/zzzFan >/dev/null 2>&1

myTemp=110

getHDDtemp()
{
myTemp=`hddtemp -u F -n /dev/sda`
}

set25()
{
echo "echo -ne 'STA\r' | tee /dev/ttyS2" > fanSpeed
echo "echo -ne 'FAN=19\r' | tee /dev/ttyS2" >> fanSpeed
echo Fan set at 25 percent.
cat fanSpeed | bash
rm fanSpeed
}

set50()
{
echo "echo -ne 'STA\r' | tee /dev/ttyS2" > fanSpeed
echo "echo -ne 'FAN=32\r' | tee /dev/ttyS2" >> fanSpeed
echo Fan set at 50 percent.
cat fanSpeed | bash
rm fanSpeed
}

set75()
{
echo "echo -ne 'STA\r' | tee /dev/ttyS2" > fanSpeed
echo "echo -ne 'FAN=4B\r' | tee /dev/ttyS2" >> fanSpeed
echo Fan set at 75 percent.
cat fanSpeed | bash
rm fanSpeed
}

set90()
{
echo "echo -ne 'STA\r' | tee /dev/ttyS2" > fanSpeed
echo "echo -ne 'FAN=5A\r' | tee /dev/ttyS2" >> fanSpeed
echo Fan set at 90 percent.
cat fanSpeed | bash
rm fanSpeed
}

setFanSpeed()
{
if [ "$myTemp" -lt 101 ]
then
set25

elif [ "$myTemp" -lt 121 ]
then
set50

elif [ "$myTemp" -lt 131 ]
then
set75

else
set90

fi
}


getHDDtemp
setFanSpeed
