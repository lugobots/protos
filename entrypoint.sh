#!/bin/sh
set -e


# protoc -I /source --go_out=/output/go --go-grpc_out=/output/go $(find /source -name '*.proto')

SRC_DIR=/source
OUT_DIR=/output

rm -rf $OUT_DIR/* && echo "Deleting previous files" || (echo "Failed to delete previous file" && exit 1)

mkdir -p $OUT_DIR/go $OUT_DIR/python $OUT_DIR/nodejs

# Generate Go code
protoc -I $SRC_DIR \
    --go_out=paths=source_relative:$OUT_DIR/go \
    --go-grpc_out=paths=source_relative:$OUT_DIR/go \
    $(find $SRC_DIR -name "*.proto") && echo "Go code generated" || (echo "Failed to generate Go code" && exit 1)

# Generate Python code
python3 -m grpc_tools.protoc -I $SRC_DIR \
    --python_out=$OUT_DIR/python \
    --grpc_python_out=$OUT_DIR/python \
    $(find $SRC_DIR -name "*.proto") && echo "Python code generated" || (echo "Failed to generate Python code" && exit 1)

# Generate Node.js code
grpc_tools_node_protoc \
      --grpc_out=grpc_js:$OUT_DIR/nodejs \
      --js_out=import_style=commonjs,binary:$OUT_DIR/nodejs  \
      -I $SRC_DIR $(find $SRC_DIR -name "*.proto") && echo "JS code generated" || (echo "Failed to generate JS code" && exit 1)

grpc_tools_node_protoc  --help

# Generating Typescript typing
grpc_tools_node_protoc \
      --plugin=protoc-gen-ts=/bin/grpc_tools_node_protoc \
      --ts_out=grpc_js:$OUT_DIR/nodejs \
      -I $SRC_DIR $(find $SRC_DIR -name "*.proto") && echo "TS code generated" || (echo "Failed to generate TS code" && exit 1)


echo "✅ Protobuf generation complete!"
