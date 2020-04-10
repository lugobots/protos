#!/bin/bash

SRC_DIR=$(pwd)/proto
echo "${SRC_DIR}"

cd proto
mkdir -p lugo
protoc -I=/usr/local/include/ -I=$SRC_DIR --go_out=plugins=grpc:lugo/  *.proto

mv lugo/*.pb.go ../lugo/
rmdir lugo