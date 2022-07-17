#!/bin/bash

echo -n "Cleaning out old files"
rm -rf protos/*/* && echo "" || exit 1

SRC_DIR=$(pwd)/src
DST_DIR=$(pwd)/proto


GENERATOR_IMG="protoc6:latest"

echo -n "Lugo - Generating Go protos: "
mkdir -p proto/go
docker run --rm -u $(id -u)  \
    -v${SRC_DIR}:/source  \
    -v${DST_DIR}/go:/output \
    -w/source $GENERATOR_IMG  \
      --proto_path=/source \
      --go_out=paths=source_relative,plugins=grpc:/output \
      -I/usr/include/google/protobuf  \
      /source/* && echo "OK!" || echo ""

echo -n "Lugo - Generating JS protos: "
mkdir -p proto/js
docker run --rm -u $(id -u)  \
    -v${SRC_DIR}:/source  \
    -v${DST_DIR}/js:/output \
    -w/source $GENERATOR_IMG  \
      --proto_path=/source \
      --js_out=import_style=commonjs,binary:/output  \
      --grpc-web_out=import_style=typescript,mode=grpcweb:/output  \
      -I/usr/include/google/protobuf  \
      /source/* && echo "OK!" || echo ""

echo -n "Lugo - Generating Python protos: "
mkdir -p proto/python
docker run --rm -u $(id -u)  \
    -v${SRC_DIR}:/source  \
    -v${DST_DIR}/python:/output \
    -w/source $GENERATOR_IMG  \
      --proto_path=/source \
      --python_out=/output  \
      -I/usr/include/google/protobuf  \
      /source/* && echo "OK!" || echo ""

