#!/bin/bash
# by TExtubation
# call this script from /etc/rc.local to change colors on system start

#set Led Mode (1=Manule 0=Rainbow)
echo 1 | tee /sys/class/leds/multicolor:chassis/device/led_mode
#set Led multi-colors (red green blue) 0-255
echo 255 0 255 | tee /sys/class/leds/multicolor\:chassis/multi_intensity
#set led brightness
echo 10 | tee /sys/class/leds/multicolor\:chassis/brightness
