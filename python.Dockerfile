FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    findutils \
    && rm -rf /var/lib/apt/lists/*
#48
# Install Python gRPC tools and compatible protobuf
RUN pip install --no-cache-dir grpcio-tools==1.47.0
RUN pip install --no-cache-dir grpcio protobuf

#RUN pip install --no-cache-dir \
#    protobuf==3.20.3 \
#    grpcio==1.51.1 \
#    grpcio-tools==1.44.0

# Set working directory
WORKDIR /workspace

# Default entrypoint: generate gRPC messages and services from mounted protos
ENTRYPOINT ["sh", "-c", "python -m grpc_tools.protoc -I./protos --python_out=./generated --grpc_python_out=./generated $(find ./protos -name '*.proto')"]
