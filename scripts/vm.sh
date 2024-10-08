#!/bin/bash

if [ -z "$vmFile" ]
  then
    echo "please set your 'vmFile' environment variable to point to your vm's .vmx file"
    exit 1
fi

case "$1" in
  start)
    vmrun start "$vmFile" nogui
    ;;
  stop)
    vmrun stop "$vmFile" nogui
    ;;
  suspend)
    vmrun suspend "$vmFile" nogui
    ;;
  pause)
    vmrun pause "$vmFile" nogui
    ;;
  unpause)
    vmrun unpause "$vmFile" nogui
    ;;
  reset)
    vmrun reset "$vmFile" nogui
    ;;
  status)
    vmrun list
    ;;
  *)
    echo "Usage: possible options are: start | stop | suspend | pause | unpause | reset | status"
    exit 1
esac
