# HDD-fan-control

Control desk fan to cool HDDs.

## Motivation

Test FreeBSD install in crap case with poor air flow. To keep drives cool an ordinary desk fan is positioned to blow in the froint of the case with the bulkhead covers removed. This keeps the drives below 40C during a scrub but is not needed at all times. It can be connected to a smart switch that can be turned on/off to maintain reasonable temperature.

### Compoinents

* Desk fan.
* TP-Link HS100 (WiFi) Smart plug.
* <https://github.com/HankB/tplink-smartplug> to manipulate the smart plug.

## Strategy

Collect the maximum temperature from all drives (including the boot SSD) and when it goes over 40C, turn the fan on. When it crops below 38C, turn the fan off.

## Errata

On FreeBSD it was convenient to link `python3.9` tp `python3`.

```text
sudo ln -sf /usr/local/bin/python3.9 /usr/local/bin/python3
```

