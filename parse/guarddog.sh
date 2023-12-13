#!/bin/bash
INPUT=$(echo $@ | sed 's/^\.\///g')
BASE=$(basename $INPUT)
SCOPE=$(echo $BASE | awk -F'-' '{print $NF}')
SOURCE=$(echo $INPUT | awk -F'/' '{print $2}')

OUTCOMES=$(cat $INPUT)

CONFIDENCE_HIGH=$(echo $OUTCOMES | grep -Eo "[0-9]+ potentially malicious indicators" | awk '{print $1}')
CONFIDENCE_MEDIUM="0"
CONFIDENCE_LOW="0"

SEVERITY_HIGH=$(echo $OUTCOMES | grep -Eo "[0-9]+ potentially malicious indicators" | awk '{print $1}')
SEVERITY_MEDIUM="0"
SEVERITY_LOW="0"

QUERY="
INSERT OR REPLACE INTO scanned(
    filename, scope, 
    source, scanner, 
    severity_low, severity_medium, severity_high, 
    confidence_low, confidence_medium, confidence_high
) VALUES ( 
    '$BASE', '$SCOPE', 
    '$SOURCE', 'guarddog',  
    ${SEVERITY_LOW:-0}, ${SEVERITY_MEDIUM:-0}, ${SEVERITY_HIGH:-0}, 
    ${CONFIDENCE_LOW:-0}, ${CONFIDENCE_MEDIUM:-0}, ${CONFIDENCE_HIGH:-0}
);"

echo "$QUERY"
sqlite3 ./bench.db "$QUERY"
