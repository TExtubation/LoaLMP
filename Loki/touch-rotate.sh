#!/bin/bash
# by TExtubation

#landscape (left)
export DISPLAY=":0"
xinput set-prop "Standard HID USB HID Touch" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1

