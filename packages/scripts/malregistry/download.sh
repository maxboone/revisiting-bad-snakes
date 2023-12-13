#!/bin/bash
mkdir -p ./packages/download
curl -L https://codeload.github.com/lxyeternal/pypi_malregistry/zip/refs/heads/main -o malregistry.zip
unzip malregistry.zip
mv pypi_malregistry-main packages/download/malregistry
rm malregistry.zip
