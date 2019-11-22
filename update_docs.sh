#!/bin/bash

docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/proto:/protos \
  pseudomuto/protoc-gen-doc --doc_opt=markdown,docs.md
