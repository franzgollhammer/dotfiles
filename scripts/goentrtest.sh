#!/bin/bash

entr bash -c "clear; go test ." < <(find .)
