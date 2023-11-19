#!/bin/bash
# by TExtubation

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo 1 | tee /sys/class/leds/multicolor:chassis/device/led_mode
echo 255 0 0 | tee /sys/class/leds/multicolor\:chassis/multi_intensity
echo 255 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.5
echo 0 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.25
echo 255 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.5
echo 0 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.25
echo 255 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.5
echo 0 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.25
echo 255 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.5
echo 0 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.25
echo 255 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.5
echo 0 | tee /sys/class/leds/multicolor\:chassis/brightness
sleep 0.25
$SCRIPT_DIR/led_colors.sh
