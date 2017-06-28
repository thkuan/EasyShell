# easy_sh

## ConnectToWiFi.sh
1. Check lsmod for your WiFi driver
```
lsmod | grep "80211"
```

2. Specify the driver on the machine with wpa_supplicant help if a change is needed
```
wpa_supplicant -h
```

3. Use wpa_passphrase to register a SSID/pwd pair in a configuration


## GenCtagsAndCscope.sh
An auxiliary tool generates DBs that were used with Vim
