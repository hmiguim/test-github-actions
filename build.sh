#!/bin/bash

set -ex

API_CHECKSUM_FILE=/tmp/assets.json

OS="linux"
JVM_IMPL="hotspot"
ARCH="x64" 
HEAP_SIZE="normal"
IMAGE_TYPE="jre"
DL_CHECKSUM="21345"


echo $(jq --version)

RESPONSE=$(curl --write-out %{http_code} https://api.adoptopenjdk.net/v3/assets/latest/8/hotspot -o $API_CHECKSUM_FILE)
if [ "${RESPONSE}" != "200" ]; then
    echo "Failed to get asset information"
    return 1
fi

API_CHECKSUM=$(cat $API_CHECKSUM_FILE | jq -r --arg os $OS --arg jvm_impl $JVM_IMPL --arg arch $ARCH --arg image_type $IMAGE_TYPE --arg heap_size $HEAP_SIZE '.[].binary | select(.image_type == $image_type) | select(.heap_size == $heap_size) | select(.architecture == $arch) | select(.jvm_impl == $jvm_impl) | select(.os == $os) | .package.checksum')

if [ $API_CHECKSUM == $DL_CHECKSUM ]; then
    echo "OK"
else
    echo "NOT OK"
fi
