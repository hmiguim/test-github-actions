#!/bin/bash

set -ex

API_CHECKSUM_FILE=/tmp/assets.json

OS="linux"
JVM_IMPL="jre"
ARCH="x64" 
IMAGE_TYPE="hotspot"
DL_CHECKSUM="21345"


echo $(jq --version)

RESPONSE=$(curl --write-out %{http_code} https://api.adoptopenjdk.net/v3/assets/latest/8/hotspot -o $API_CHECKSUM_FILE)
if [ "${RESPONSE}" != "200" ]; then
    echo "Failed to get asset information"
    return 1
fi

cat $API_CHECKSUM_FILE

API_CHECKSUM=$(jq -r --arg os $OS --arg jvm_impl $JVM_IMPL --arg arch $ARCH --arg image_type $IMAGE_TYPE '.[].binary | select(.image_type == $image_type) | select(.heap_size == "normal") | select(.architecture == $arch) | select(.jvm_impl == $jvm_impl) | select(.os == $os) | .package.checksum' $API_CHECKSUM_FILE)

if [ $API_CHECKSUM == $DL_CHECKSUM ]; then
    echo "OK"
else
    echo "NOT OK"
fi
