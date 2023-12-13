#!/bin/bash
cat ./bench/*.batch | parallel --bar --joblog ./parallel.log --resume -j 8 --timeout 600
