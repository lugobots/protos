FROM debian:12.10-slim

# Versions
ENV GO_VERSION=1.23.0
ENV PROTOC_VERSION=27.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git build-essential python3 python3-pip npm node-gyp \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -L https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

# Install protoc
RUN curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip \
    && unzip protoc-${PROTOC_VERSION}-linux-x86_64.zip -d /usr/local \
    && rm protoc-${PROTOC_VERSION}-linux-x86_64.zip

# Install Go plugins for protoc
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Install Python gRPC tools (allow breaking system packages)
RUN pip3 install --break-system-packages grpcio grpcio-tools

# Install Node.js gRPC tools and dependencies
RUN npm install -g node-pre-gyp grpc-tools protoc-gen-grpc

# Working directory for mounted volumes
WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/build-protos
RUN chmod +x /usr/local/bin/build-protos

ENTRYPOINT ["build-protos"]
