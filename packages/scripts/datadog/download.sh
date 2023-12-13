#!/bin/bash
mkdir -p ./packages/download/datadog
curl -L https://codeload.github.com/DataDog/malicious-software-packages-dataset/zip/refs/heads/main -o datadog.zip
unzip datadog.zip
mv malicious-software-packages-dataset-main/* packages/download/datadog
rm datadog.zip
