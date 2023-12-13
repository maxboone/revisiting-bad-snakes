#!/bin/bash
mkdir -p ./packages/download/downloaded
./packages/scripts/downloaded/download.py | xargs -n1 -P8 curl --output-dir ./packages/download/downloaded -LO
