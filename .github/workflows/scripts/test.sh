#!/bin/bash

if [ "$OS" == "macOS" ]; then
    SHASUM=$(echo "adasdadsa" | shasum -a 256)
else
    SHASUM=$(echo "adasdadsa" | sha256sum)
fi 

echo $SHASUM