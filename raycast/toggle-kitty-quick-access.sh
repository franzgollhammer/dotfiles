#!/bin/bash

# Raycast script command — toggle kitty's quick access terminal (quake window).
#
# kitty has no global hotkey API, so the hotkey has to be registered by
# something else. Add this directory in Raycast → Extensions → Script Commands
# → Add Script Directory, then give the command the cmd+# hotkey — ghostty's
# `global:cmd+#=toggle_visibility` is commented out in ghostty/config so the key
# is free.
#
# Config for the window itself: kitty/quick-access-terminal.conf.
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle kitty quick access
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🐱
# @raycast.packageName kitty
# @raycast.description Show/hide the kitty quick access terminal
# @raycast.author fg

# Absolute path: Raycast does not run a login shell, so $PATH may not have kitten.
KITTEN=/Applications/kitty.app/Contents/MacOS/kitten

# First call starts the panel (single instance, stays resident), every later call
# toggles it. `kitten quick-access-terminal` blocks for as long as the panel
# lives, so it has to be detached — its own --detach flag silently does nothing
# when launched from Raycast, hence nohup.
nohup "$KITTEN" quick-access-terminal >/dev/null 2>&1 &
disown
