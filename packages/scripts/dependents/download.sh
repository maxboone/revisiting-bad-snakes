#!/bin/bash
mkdir -p ./download/dependents
./packages/scripts/dependents/download.py | xargs -n1 curl -fsLO --output-dir ./packages/download/dependents 
