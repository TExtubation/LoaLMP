#!/bin/bash
# https://yad-guide.ingk.se/
#
# script determins its own location
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# script checks to see if it is being run as root and calls itself with sudo if it is not
test "$(id -u)" != 0 && exec sudo $SCRIPT_DIR/yad-led.sh "$@"

# calls mode, color, and brightness from hardware to place in varables
cmode=`cat /sys/class/leds/multicolor:chassis/device/led_mode`;
ccolor=`cat /sys/class/leds/multicolor\:chassis/multi_intensity`;
cbright=`cat /sys/class/leds/multicolor\:chassis/brightness`;

# cuts color RGB variable into seperate red, green, blue variables
cred=`echo $ccolor | cut -d " " -f 1`;
cgreen=`echo $ccolor | cut -d " " -f 2`;
cblue=`echo $ccolor | cut -d " " -f 3`;

# converts seperate colors into single hex variable
chexcolor=`printf '#%02x%02x%02x\n' "$cred" "$cgreen" "$cblue"`
echo $hexcolor

# yad command
yad \
  --title="Loki LED Control" \
  --form \
    --text="Options: Hover for more info" \
    --separator="," \
    --field="Mode:!0 is the default Rainbow mode that cycles through the colors automatically. 1 is manual mode and allows the function of the options below:" \
	--field="		(0=Rainbow 1=Manual):LBL" \
    --field="Color:!Due to color variations within the physical leds they may not show the exact color chosen from this option:CLR" \
    --field="Brightness:!A brightness must be selected otherwise it defaults to 0:" \
	--field="		(0-255):LBL" \
    "$cmode" \
    "" \
    "$chexcolor" \
    "$cbright" \
    "" | while read line; do
  nmode=$(echo $line | awk 'BEGIN {FS="," } { print $1 }')
  nhexcolor=$(echo $line | awk 'BEGIN {FS="," } { print $3 }')
  nbright=$(echo $line | awk 'BEGIN {FS="," } { print $4 }')
# convert new hex color back to RGB
  : "${nhexcolor/\#/}"
  if (( ${#_} == 6 )); then
    ((r = 16#${_:0:2}, g = 16#${_:2:2}, b = 16#${_:4:2}))
  fi
  ncolor=`echo $r $g $b`
  echo $ccolor $chexcolor $nmode $ncolor $nhexcolor $nbright
# Write new mode, color, brightness to hardware
  echo $nmode | tee /sys/class/leds/multicolor:chassis/device/led_mode
  echo $ncolor | tee /sys/class/leds/multicolor\:chassis/multi_intensity
  echo $nbright | tee /sys/class/leds/multicolor\:chassis/brightness
# Write new variables as script into led_colors.sh so it can be called at system startup from rc.local
cat > $SCRIPT_DIR/led_colors.sh <<EOF
#!/bin/bash

#set Led Mode (1=Manule 0=Rainbow)
echo $nmode | tee /sys/class/leds/multicolor:chassis/device/led_mode
#set Led multi-colors (red blue green) 0-255
echo $ncolor | tee /sys/class/leds/multicolor\:chassis/multi_intensity
#set led brightness
echo $nbright | tee /sys/class/leds/multicolor\:chassis/brightness
EOF
done
