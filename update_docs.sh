#!/bin/bash

docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/src:/protos \
  pseudomuto/protoc-gen-doc --doc_opt=markdown,docs.md
