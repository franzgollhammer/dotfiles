#!/bin/zsh
printf "Cleanup mongodb processes ...\n"
killall -u "$(whoami)" mongo
