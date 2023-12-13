#!/bin/bash

mkdir -p /tmp/package

if test -f "/tmp/package.tar.gz"; then
    tar xf /tmp/package.tar.gz -C /tmp/package
fi

if test -f "/tmp/package.zip"; then
   unzip -P infected /tmp/package.zip -d /tmp/package
fi

exec $@
