#!/bin/zsh

entr bash -c "clear; go test ." < <(find .)
