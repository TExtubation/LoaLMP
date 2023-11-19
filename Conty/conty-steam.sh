#!/bin/bash

xset -dpms
killall antimicrox
# call the provided conty.sh for steam
/home/myusername/Conty/conty.sh steam -start steam://open/bigpicture -fulldesktopres && xset +dpms && antimicrox &
