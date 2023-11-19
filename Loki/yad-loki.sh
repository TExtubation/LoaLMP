#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
icon="$SCRIPT_DIR/Loki.png"

yad --notification \
  --image="$icon" \
  --icon-size="46" \
  --text="Loki System Control" \
  --menu="LED Controls ! bash -c 'sudo $SCRIPT_DIR/yad-led.sh' \
|Custom Conty Script Maker ! bash -c '/$SCRIPT_DIR/yad-csm.sh' \
|Fix Touch Rotation ! bash -c '/$SCRIPT_DIR/touch-rotate.sh; yad --button="yad-ok"' \
|Bluetooth Fix ! bash -c '/$SCRIPT_DIR/loki-bt-fix.sh' \
|Quit ! pkill -f 'yad-loki.sh'" \
 --command="bash -c '$SCRIPT_DIR/touch-rotate.sh; yad --button="yad-ok"'"
