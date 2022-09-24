#!/bin/bash

echo -n "Cleaning out old files"
rm -rf proto/* && echo "" || exit 1

SRC_DIR=$(pwd)/src
DST_DIR=$(pwd)/proto

TS_GEN_IMG="ts_typing_maker"
docker build -t ${TS_GEN_IMG} -f TypescriptTypingGen.Dockerfile .

# Build the image jaegertracing/protobuf:0.3.1 project with this command:
# docker build -t jaegertracing_updated --build-arg GRPC_VERSION=1.48.0 .
GENERATOR_IMG="jaegertracing_updated"

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
docker run --init --rm -u $(id -u) \
      -v ${SRC_DIR}:/base/src \
      -v ${DST_DIR}/js:/base/proto/js \
      -w /base/src $TS_GEN_IMG grpc_tools_node_protoc \
      --grpc_out=grpc_js:/base/proto/js \
      --js_out=import_style=commonjs,binary:/base/proto/js  \
      -I/base/src broadcast.proto server.proto remote.proto physics.proto  && echo "OK!" || echo ""



echo -n "Lugo - Generating Typescript typing: "
mkdir -p proto/ts
docker run --init --rm -u $(id -u) \
      -v ${SRC_DIR}:/base/src \
      -v ${DST_DIR}/ts:/base/proto/ts \
      -w /base/src $TS_GEN_IMG grpc_tools_node_protoc \
      --plugin=protoc-gen-ts=/bin/grpc_tools_node_protoc \
      --ts_out=grpc_js:/base/proto/ts \
      -I/base/src broadcast.proto server.proto remote.proto physics.proto  && echo "OK!" || echo ""


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

