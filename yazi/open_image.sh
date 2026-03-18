#!/usr/bin/env bash

# uses imv-dir if only one argument is passed in,
# uses imv otherwise.
if [ "$#" -eq 1 ]; then
    imv-dir "$@"
else
    imv "$@"
fi
