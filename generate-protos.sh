#!/bin/bash

SRC_DIR=$(pwd)/proto
DST_DIR=$(pwd)/lugo

echo "${SRC_DIR}"

cd proto
mkdir -p lugo
protoc -I=/usr/local/include/ -I=$SRC_DIR --go_out=plugins=grpc:lugo/  *.proto

#python -m pip install grpcio
#python -m pip install grpcio-tools
python -m grpc_tools.protoc  -I=$SRC_DIR --python_out=${DST_DIR} --grpc_python_out=${DST_DIR} *.proto
