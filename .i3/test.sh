#!/bin/bash

echo "{ \"version\": 1, \"click_events\": true }"
echo "[[]"
conky -d -c ~/.i3/testconky

IFS="}"
while read;do
  IFS=" "
  STR=`echo $REPLY | sed -e s/[{}]//g -e "s/ \"/\"/g" | awk '{n=split($0,a,","); for (i=1; i<=n; i++) {m=split(a[i],b,":"); if (b[1] == "\"name\"") {NAME=b[2]} if (b[1] =="\"x\"") {X=b[2]} if (b[1] =="\"y\"") {Y=b[2]} } print NAME " " X " " Y}'`
  read NAME X Y <<< $STR
  X=$(($X-50))
  case "${NAME}" in
    \"updates\")
      notify-send -a "Available updates" -u normal "$(yaourt -Qu)" &
      ;;
    \"mpd_i\")
      mpc --quiet toggle &
      ;;
    \"mpd_r\")
      mpc --quiet random &
      ;;
    \"mpd_t\")
      mpc --quiet prev &
      ;;
     \"mpd_a\")
      mpc --quiet next &
      ;;
     \"mpd_-\")
      mpc --quiet stop &
      ;;
     \"mpd_b\")
      i3-msg -q "exec --no-startup-id urxvt -title music -e ncmpcpp" &
      ;;
    \"time\")
      notify-send -a "Calendar" -u normal "$(cal)" &
      ;;
     \"menu\")
     i3-msg -q "exec --no-startup-id sh ~/.config/i3/scripts/menu" &
      ;;
    \"date\")
      i3-msg -q "exec --no-startup-id yad --no-buttons --sticky --geometry=+886+24 --class "CALENDAR" --calendar" &
      sleep 10 && killall yad &
      ;;
    \"kill\")
      i3-msg -q "kill" &
      ;;
    \"maxi\")
      i3-msg -q "floating toggle" &
      ;;
    \"mini\")
      i3-msg -q "border toggle" &
      ;;
    \"temp\")
      notify-send -a "Temperatures" -u normal "$(temp_nc)" &
      ;;
    \"bat\")
      notify-send -a "Battery" -u normal "$(sh ~/.config/i3/scripts/battery)" &
      ;;
    \"net_up\")
      notify-send -a "External IP" -u normal "$(sh ~/.config/i3/scripts/ip-external)" &
      ;;
    \"net_down\")
      notify-send -a "Internal IP" -u normal "$(sh ~/.config/i3/scripts/ip-internal)" &
      ;;
    \"net_up_i\")
      i3-msg -q "exec --no-startup-id firefox" &
      ;;
     \"net_down_i\")
      i3-msg -q "exec --no-startup-id chromium" &
      ;;
    \"kernel\")
      i3-msg -q "exec --no-startup-id xfce4-appfinder" &
      ;;
    \"home\")
      notify-send -a "Disks mounted" -u normal "$(dfc -d | grep /dev/sda && dfc -d | grep /dev/sdb)" &
      ;;
    \"fsicon\")
      i3-msg -q "exec --no-startup-id thunar" &
      ;;
    \"mem\")
      notify-send -a "RAM" -u normal "$(free -m | grep total && free -m | grep Mem)" &
      ;;
    \"cpu\")
      i3-msg -q "exec --no-startup-id xfce4-taskmanager" &
      ;;
    \"bright\")
      ~/.config/i3/scripts/lightdown &
      ;;
     \"bright_i\")
      ~/.config/i3/scripts/lightup &
      ;;
    \"volume\")
      i3-msg -q "exec --no-startup-id pavucontrol" &
      ;;
    *)
      ;;
  esac
  IFS="}"
done
