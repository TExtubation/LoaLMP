#!/bin/bash

ps -C xvkbd
var=`echo $?`
if [ $var -eq 0 ]; then
  echo $var
  pkill xvkbd
else
  echo $var
  xvkbd -modal -geometry 1920x400+0+680 -compact -xrm 'xvkbd*Font: -*-*-*-*-*-*-50-*-*-*-*-*-*-*' -xrm 'xvkbd.customization: -custom'
fi
