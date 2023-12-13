#!/bin/bash
INPUT=$(echo $@ | sed 's/^\.\///g')
BASE=$(basename $INPUT)
SCOPE=$(echo $BASE | awk -F'-' '{print $NF}')
SOURCE=$(echo $INPUT | awk -F'/' '{print $2}')

OUTCOMES=$(cat $INPUT | tail -n1 | jq -r '.[] | flatten[]' | grep -oE "'classification': '\w+'|'confidence': '\w+'" | sort | uniq -c)

CONFIDENCE_HIGH=$(echo $OUTCOMES | grep -o "[0-9]* 'confidence': 'high'" | awk '{print $1}')
CONFIDENCE_MEDIUM="0"
CONFIDENCE_LOW="0"

SEVERITY_HIGH=$(echo $OUTCOMES | grep -o "[0-9]* 'classification': 'threat'" | awk '{print $1}')
SEVERITY_MEDIUM="0"
SEVERITY_LOW=$(echo $OUTCOMES | grep -o "[0-9]* 'classification': 'indeterminate'" | awk '{print $1}')

QUERY="
INSERT OR REPLACE INTO scanned(
    filename, scope, 
    source, scanner, 
    severity_low, severity_medium, severity_high, 
    confidence_low, confidence_medium, confidence_high
) VALUES ( 
    '$BASE', '$SCOPE', 
    '$SOURCE', 'pypi',  
    ${SEVERITY_LOW:-0}, ${SEVERITY_MEDIUM:-0}, ${SEVERITY_HIGH:-0}, 
    ${CONFIDENCE_LOW:-0}, ${CONFIDENCE_MEDIUM:-0}, ${CONFIDENCE_HIGH:-0}
);"

echo "$QUERY"
sqlite3 ./bench.db "$QUERY"
