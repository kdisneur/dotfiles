#!/usr/bin/env bash

notificationID="";

while true; do
  batteryLevel=$(cat /sys/class/power_supply/BAT0/capacity);
  status=$(cat /sys/class/power_supply/BAT0/status);

  if [ "${batteryLevel}" -le 15 -a "${status}" = "Discharging" ]; then
    option=""
    if [ -n "${notificationID}" ]; then
      option="--replace-id=${notificationID}";
    fi

    notificationID=$(notify-send \
      --print-id \
      --urgency critical \
      ${option} \
      "Battery Low" \
      "Battery is reaching <b>${batteryLevel}%</b>. Please charge as soon as possible"
    );

    sleep 1m
  fi
done
