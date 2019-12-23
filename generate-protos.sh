#!/bin/bash

SRC_DIR=$(pwd)/
echo $SRC_DIR

mkdir -p lugo
protoc -I=/usr/local/include/ -I=$SRC_DIR --go_out=plugins=grpc:lugo/  proto/*.proto

mv lugo/proto/*.pb.go lugo/
rmdir lugo/proto