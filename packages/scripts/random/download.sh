#!/bin/bash

mkdir -p ./packages/download/random

packages=$(curl -s https://pypi.org/simple/ | grep -o "/simple/[a-zA-Z0-9\-\_]*/" | sed 's/simple//g' | sed 's/\///g' | shuf -n 1000)

for i in $packages; do
    url=$(curl -s "https://pypi.org/simple/$i/" | grep -o "https://.*#" | sed 's/#$//' | tail -n1)
    curl -L -o ./packages/download/random/$(basename $url) $url
done
