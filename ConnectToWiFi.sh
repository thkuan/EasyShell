#!/bin/sh

kill $(pgrep NetworkManager) 2>/dev/null
kill $(pgrep wpa_supplicant) 2>/dev/null
ifconfig wlan0 up
wpa_supplicant -B -i wlan0 -D nl80211 -c /etc/wpa_supplicant.conf 1>/var/log/wifi.log

# Release DHCP IP
dhclient -r wlan0
# Retreive DHCP IP
dhclient wlan0
