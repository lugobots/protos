#!/bin/bash

echo -n "Cleaning out old files"
rm -rf proto/*/* && echo "" || exit 1

SRC_DIR=$(pwd)/src
DST_DIR=$(pwd)/proto

TS_GEN_IMG="ts_typing_maker"
docker build -t ${TS_GEN_IMG} -f TypescriptTypingGen.Dockerfile .

GENERATOR_IMG="jaegertracing/protobuf:0.3.1"

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
      --js_out=import_style=typescript,binary:/output  \
      --grpc_out=minimum_node_version=8:/output \
      --plugin=protoc-gen-grpc=/usr/bin/grpc_node_plugin \
      -I/usr/include/google/protobuf  \
      /source/* && echo "OK!" || echo ""

echo -n "Lugo - Generating Typescript typing: "
# TODO passing `/source/*` instead of all files. For some reason it is failing
docker run --init --rm -u $(id -u) \
      -v${SRC_DIR}:/source  \
      -v${DST_DIR}/js:/output \
      -w/source $TS_GEN_IMG \
      protoc \
      --proto_path=/source \
    --plugin=protoc-gen-ts=/bin/grpc_tools_node_protoc \
    --ts_out=/output \
    -I/source broadcast.proto server.proto remote.proto physics.proto && echo "OK!" || echo ""

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

