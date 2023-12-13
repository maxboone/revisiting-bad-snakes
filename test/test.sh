#!/bin/bash
# First run over requests
docker run --rm --runtime runsc -v ./pkg/benign.tar.gz:/tmp/package.tar.gz:ro secproj-ossgadget oss-detect-backdoor /tmp/package > output/benign-ossg
docker run --rm --runtime runsc -v ./pkg/benign.tar.gz:/tmp/package.tar.gz:ro secproj-bandit4mal bandit -r /tmp/package > output/benign-b4m
docker run --rm --runtime runsc -v ./pkg/benign.tar.gz:/tmp/package.tar.gz:ro secproj-pypi /app/pypi.py /tmp/package > output/benign-pypi
docker run --rm --runtime runsc -v ./pkg/benign.tar.gz:/tmp/package.tar.gz:ro secproj-guarddog guarddog pypi scan /tmp/package > output/benign-gd

# Then over malicious
docker run --rm --runtime runsc -v ./pkg/malicious.zip:/tmp/package.zip:ro secproj-ossgadget oss-detect-backdoor /tmp/package > output/malicious-ossg
docker run --rm --runtime runsc -v ./pkg/malicious.zip:/tmp/package.zip:ro secproj-bandit4mal bandit -r /tmp/package > output/malicious-b4m
docker run --rm --runtime runsc -v ./pkg/malicious.zip:/tmp/package.zip:ro secproj-pypi /app/pypi.py /tmp/package > output/malicious-pypi
docker run --rm --runtime runsc -v ./pkg/malicious.zip:/tmp/package.zip:ro secproj-guarddog guarddog pypi scan /tmp/package > output/malicious-gd



