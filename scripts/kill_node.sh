#!/bin/zsh
printf "Cleanup node processes ...\n"
killall -u "$(whoami)" node
