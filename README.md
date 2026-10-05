# AIO addon framework for LonelyIce

AIO server scripts and WoW 3.3.5 client addon packaged together. Requires mod-ale. The launcher installs AIO_Client into Interface/AddOns; headless administrators distribute this addon to each player.

Upstream: https://github.com/Rochet2/AIO.git

Pinned source: `087e279cdf90ff5d4343dc1569e9d3c3c5cc8548`.

This repository contains packaging, build configuration and patches, not a fork of upstream. Add its path to `LONELYICE_PLUGIN_DIRS` when building LonelyIce. Install the resulting package through the launcher or `--pkg install`.
