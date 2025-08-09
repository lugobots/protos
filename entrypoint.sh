#!/bin/sh
set -e


# protoc -I /source --go_out=/output/go --go-grpc_out=/output/go $(find /source -name '*.proto')

SRC_DIR=/source
OUT_DIR=/output

rm -rf $OUT_DIR/* && echo "" || exit 1

mkdir -p $OUT_DIR/go $OUT_DIR/python $OUT_DIR/nodejs

# Generate Go code
protoc -I $SRC_DIR \
    --go_out=paths=source_relative:$OUT_DIR/go \
    --go-grpc_out=paths=source_relative:$OUT_DIR/go \
    $(find $SRC_DIR -name "*.proto")

# Generate Python code
python3 -m grpc_tools.protoc -I $SRC_DIR \
    --python_out=$OUT_DIR/python \
    --grpc_python_out=$OUT_DIR/python \
    $(find $SRC_DIR -name "*.proto")

## Generate Node.js code
#protoc -I $SRC_DIR \
#  --js_out=import_style=commonjs,binary:$OUT_DIR/nodejs \
#  --grpc_out=$OUT_DIR/nodejs \
#  --plugin=protoc-gen-grpc=$(which grpc_tools_node_protoc_plugin) \
#  $(find $SRC_DIR -name "*.proto")


echo "✅ Protobuf generation complete!"
