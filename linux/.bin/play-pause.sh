#!/usr/bin/env bash

file=/tmp/play-pause.value

if [ ! -e "${file}" ]; then
  echo "Play" > "${file}"
fi

case $(cat "${file}") in
  Play)
    state=Pause;

    ;;
  Pause)
    state=Play;
    ;;
  *)
    >&2 echo "state in ${file} should be either play or pause"
    exit 1
esac

gdbus call \
  --session \
  --dest org.freedesktop.DBus \
  --object-path /org/freedesktop/DBus \
  --method org.freedesktop.DBus.ListNames \
  | grep -Eo "org.mpris.MediaPlayer2[^,']+" \
  | xargs -I{} dbus-send --print-reply --dest={} /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.${state}

echo "${state}" > "${file}"
