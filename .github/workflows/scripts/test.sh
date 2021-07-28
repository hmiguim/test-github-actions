#!/bin/bash

$FILE="./file2"

if [ "$OS" == "Windows" ]; then
    SHASUM=$(sha256sum $FILE)
    echo $SHASUM
fi
