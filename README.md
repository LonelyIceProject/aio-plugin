# AIO addon framework for LonelyIce

AIO server scripts and WoW 3.3.5 client addon packaged together. Requires mod-ale. The launcher installs AIO_Client into Interface/AddOns; headless administrators distribute this addon to each player.

Upstream: https://github.com/Rochet2/AIO.git

Pinned source: `087e279cdf90ff5d4343dc1569e9d3c3c5cc8548`.

This repository contains packaging, build configuration and patches, not a fork of upstream. Add its path to `LONELYICE_PLUGIN_DIRS` when building LonelyIce. Install the resulting package through the launcher or `--pkg install`.

## Building

Requires a LonelyIce build using core ABI `lonelyice-ac-2`, CMake, Git and the core's C++ dependencies. Add this repository's absolute path to the semicolon-separated `LONELYICE_PLUGIN_DIRS` CMake option; CMake fetches the pinned upstream revision and applies the patches in `patches/`. It never modifies your upstream checkout. Windows x64 and Linux x64 are supported.

```sh
cmake -S /path/to/lonelyice -B /path/to/build -DLONELYICE_CORE_DIR=/path/to/core -DLONELYICE_PLUGIN_DIRS=/path/to/aio-plugin
cmake --build /path/to/build --config RelWithDebInfo --target aio-files
```

The plugin folder is written under the build's `bin/plugins` directory (`bin/RelWithDebInfo/plugins` with Visual Studio). Package it with `LonelyIce --pkg pack <plugin-folder> <output-folder>`. The release ZIP contains both platform libraries where applicable. Source revisions are recorded in `plugin.json`; the port's source and patches remain available in this repository under the upstream license.

## Installing and using

Install `aio` from the catalog; the launcher resolves its `mod-ale` dependency. Restart the server and apply client addons with the launcher or `--pkg apply --client <WoW-folder>`. On a headless server copy `client/addons/AIO_Client` from the installed package to each player's `Interface/AddOns/AIO_Client` directory. Restart the game client or reload its UI.

AIO is a framework for custom Lua interfaces; installing it alone does not add a ready-made gameplay interface. Consumer packages should depend on `aio`, put server Lua under `lua/`, and load it with `local AIO = require("AIO")`. Addon messages and client-supplied arguments must be validated by each server handler. The upstream examples are not enabled automatically.

Run the isolated host smoke test with `lua tests/smoke.lua /path/to/AIO_Server` (Lua 5.2 or LuaJIT).

Mythic Plus uses its own `MPUi` protocol and does not become an AIO interface automatically. A mocked Lua host smoke test verified bootstrap, event registration, message serialization and protocol separation; actual ALE and WoW client interaction still requires in-game testing.
