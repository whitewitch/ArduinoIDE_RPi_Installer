#!/bin/bash
#
#arduinoide-rpi-installer
#-----------------------------
#Author:       WhiteWitch <http://www.github.com/whitewitch>, <whitewitchdev@gmx.com>
#Filename:     installer.sh
#Version:      0.2
#License:      MIT License
#Description:  Intall Arduino IDE on the Raspberry Pi.
#	           Just run ./installer.sh and wait a few minutes.
#-----------------------------

version=1.0.5
file=arduino-$version-linux32.tgz 
cd ~
echo "Updating package lists..."
sudo apt-get update
echo "Downloading the Arduino tar archive. It may take some time..."
wget https://arduino.googlecode.com/files/$file > /dev/null 2>&1
if [ -f $file ]; then
echo "Done! Extracting the archive..."
tar zxf $file
rm $file
echo "Installing required libraries..."
sudo apt-get install avr-libc libftdi1 avrdude openjdk-6-jre librxtx-java arduino-core extra-xdg-menus libjna-java arduino-mk libjna-java-doc /dev/null > /dev/null 2>&1
cd arduino-$version
for i in $(find . -name "librxtxSerial.so") ; do cp /usr/lib/jni/librxtxSerial.so $i ; done
for i in $(find . -name "RXTXcomm.jar") ; do cp /usr/share/java/RXTXcomm.jar $i ; done
cp /usr/bin/avrdude /home/pi/arduino-$version/hardware/tools/avrdude
cp /etc/avrdude.conf /home/pi/arduino-$version/hardware/tools/avrdude.conf
mv ~/arduino-$version/hardware/tools/avr/bin ~/arduino-$version/hardware/tools/avr/bin_old

echo "Would you like to make a Desktop shortcut? [Y/n]"
read shortcut
if [[ "$shortcut" == "Y" || "$shortcut" == "y" ]]; then
	cd ~/arduino-$version
	echo "Downloading Arduino icon and making the shortcut..."
	wget http://s9.postimg.org/q7hxds227/arduino_logo.png > /dev/null 2>&1
	echo "
	[Desktop Entry]
	Encoding=UTF-8
	Type=Application
	Name=Arduino
	Comment=Arduino
	Icon=$HOME/arduino-$version/arduino_logo.png
	Exec=sh -c '~/arduino-1.0.5/arduino'
	NoDisplay=true" > ~/Desktop/Arduino.desktop
	echo "Done!"
else
	echo "No problem!"
fi

echo "Anyway, would you like to launch Arduino software now? [Y/n]"
read launch
if [[ "$launch" == "Y" || "$launch" == "y" ]]; then
	echo "Launching..."
	~/arduino-$version/arduino > /dev/null 2>&1
else
	echo "OK. To launch it, run ./arduino at ~/arduino-$version. Cya!"
fi

else
echo "File not found. Check your internet connection and try again..."
fi


