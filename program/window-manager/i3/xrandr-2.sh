#!/bin/bash
connectedOutputs=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
cute="xrandr "
xrandr --auto
main="eDP-1"
if echo $connectedOutputs | grep "HDMI-1";
  then cute=$cute"--output $main --below HDMI-1";
  echo $cute; `$cute`;
elif echo $connectedOutputs | grep "HDMI-2";
  then cute=$cute"--output $main --below HDMI-2";
  echo $cute; `$cute`;
fi;
