#!/bin/bash

read -p "Enter the port number: " port

pid=$(lsof -i :$port | awk 'NR==2{print $2}')

if [[ -z $pid ]]; then
  echo "No process found running on port $port."
else
  echo "Killing process with PID $pid..."
  kill -9 $pid
  echo "Process killed successfully."
fi
  