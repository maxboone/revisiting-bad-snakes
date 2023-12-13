#!/bin/bash
mv ./bench.db ./bench.db.$(date +%s)
sqlite3 ./bench.db < schema.sql 
find ./bench -type f -name '*bandit4mal*' | xargs -n1 ./parse/bandit4mal.sh
find ./bench -type f -name '*guarddog*' | xargs -n1 ./parse/guarddog.sh
find ./bench -type f -name '*ossgadget*' | xargs -n1 ./parse/ossgadget.sh
find ./bench -type f -name '*pypi*' | xargs -n1 ./parse/pypi.sh
