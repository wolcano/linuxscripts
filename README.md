## control the tp-link hs100, hs110 and hs200 wlan smart plugs

Script to connect over TCP/IP to an hs100/hs110 smart plug, switch it on and off. You'll need the IP address and port (was 9999 in my tests) and a command, e.g.:

Switch plug on:
```sh
hs100.cmd on 192.168.1.20 9999
```

Switch plug off:
```sh
hs100.cmd off 192.168.1.20 9999
```

