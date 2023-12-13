#!/bin/bash
INPUT=$(echo $@ | sed 's/^\.\///g')
BASE=$(basename $INPUT)
SCOPE=$(echo $BASE | awk -F'-' '{print $NF}')
SOURCE=$(echo $INPUT | awk -F'/' '{print $2}')

OUTCOMES=$(cat $INPUT | grep -E 'Severity:|Confidence:' | sed 's/[,:]//g' | awk '{ print $1,$2 "\n" $3,$4 }' | sort | uniq -c)

CONFIDENCE_HIGH=$(echo $OUTCOMES | grep -o "[0-9]* Confidence High" | awk '{print $1}')
CONFIDENCE_MEDIUM=$(echo $OUTCOMES | grep -o "[0-9]* Confidence Medium" | awk '{print $1}')
CONFIDENCE_LOW=$(echo $OUTCOMES | grep -o "[0-9]* Confidence Low" | awk '{print $1}')

SEVERITY_HIGH=$(echo $OUTCOMES | grep -o "[0-9]* Severity High" | awk '{print $1}')
SEVERITY_MEDIUM=$(echo $OUTCOMES | grep -o "[0-9]* Severity Medium" | awk '{print $1}')
SEVERITY_LOW=$(echo $OUTCOMES | grep -o "[0-9]* Severity Low" | awk '{print $1}')

QUERY="
INSERT OR REPLACE INTO scanned(
    filename, scope, 
    source, scanner, 
    severity_low, severity_medium, severity_high, 
    confidence_low, confidence_medium, confidence_high
) VALUES ( 
    '$BASE', '$SCOPE', 
    '$SOURCE', 'bandit4mal',  
    ${SEVERITY_LOW:-0}, ${SEVERITY_MEDIUM:-0}, ${SEVERITY_HIGH:-0}, 
    ${CONFIDENCE_LOW:-0}, ${CONFIDENCE_MEDIUM:-0}, ${CONFIDENCE_HIGH:-0}
);"

echo "$QUERY"
sqlite3 ./bench.db "$QUERY"
