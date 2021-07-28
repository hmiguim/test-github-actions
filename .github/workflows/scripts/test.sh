#!/bin/bash

if [ "$OS" == "Windows" ]; then
    SHASUM=$(echo "adasdadsa" | sha256sum)
    echo $SHASUM
fi
