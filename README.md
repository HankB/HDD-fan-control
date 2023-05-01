# HDD-fan-control

Control desk fan to cool HDDs.

## Motivation

FreeBSD install (for testing) in crap case with poor air flow. To keep drives cool an ordinary desk fan is positioned to blow in the front of the case with the bulkhead covers removed. This keeps the drives below 40C during a scrub but is not needed at all times. It can be connected to a smart switch that can be turned on/off to maintain reasonable temperature.

### Components

* Desk fan.
* TP-Link HS100 (WiFi) Smart plug.
* <https://github.com/HankB/tplink-smartplug> to manipulate the smart plug.

### Requirements

* `bash`
* `jq`

## Strategy

Collect the maximum temperature from all drives (including the boot SSD) and when it goes over 40C, turn the fan on. When it crops below 38C, turn the fan off.

## Status

Little more than a hack, works for me.

## TODO

Don't hard code the smart plug address! (worse yet, in several places in the code.)

## Errata

On FreeBSD it was convenient to link `python3.9` tp `python3`.

```text
sudo ln -sf /usr/local/bin/python3.9 /usr/local/bin/python3
```

The script uses `bash` which is not installed by default. It is not easy to determine if the user is root using `sh` on both Linux and BSD.

The script uses `jq` to parse the results from querying the smart plug in order to determine the current state.

