#!/bin/sh
if [ ! -e /data/eGTouchA.ini ]; then
  cp /system/etc/eGTouchA.ini /data/eGTouchA.ini
fi

if busybox lsusb | grep 0eef; then
  /system/bin/eGTouchD
fi
