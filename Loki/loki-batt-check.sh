#!/bin/bash
# by TExtubation

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

time=60

while true; do
    percent="$(< /sys/class/power_supply/BAT0/capacity)"
    adapt="$(< /sys/class/power_supply/ADP1/online)"
    case $adapt in
        0)
            printf "The adaptor is not plugged in\n"
            if [ "$percent" -lt 26 ]; then
                $SCRIPT_DIR/loki-batt-low.sh
				time=10
            fi
            ;;
        1)
            printf "The adaptor is plugged in\n"
			time=60
            ;;
        *)
            error_exit "Adaptor status check returned invalid value"
            ;;
    esac

    sleep $time
done
