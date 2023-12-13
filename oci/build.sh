#!/bin/bash
docker build -t secproj-pypi ./oci/pypi
docker build -t secproj-guarddog ./oci/guarddog
docker build -t secproj-bandit4mal ./oci/bandit4mal
docker build -t secproj-ossgadget ./oci/ossgadget

