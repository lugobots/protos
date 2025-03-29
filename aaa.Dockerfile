FROM debian:12.10-slim
#
#docker run -ti python:3.9.21 /bin/bash
#python -m pip install --upgrade pip
#pip3 install --upgrade pip
#pip3 install --no-cache-dir  --force-reinstall -Iv grpcio==1.71
#python -m pip install grpcio-tools
#python -m grpc_tools.protoc -I./ --python_out=. --pyi_out=. --grpc_python_out=. test.proto
FROM debian:12.10-slim
RUN apt update && apt install -y build-essential python3 -y python3-pip python3.11-venv protobuf-compiler curl git
RUN python3 -m venv /opt/py_envs && \
  /opt/py_envs/bin/python -m pip install grpcio-tools
#

RUN curl -L --fail -o go1.23.7.linux-amd64.tar.gz https://go.dev/dl/go1.23.7.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.23.7.linux-amd64.tar.gz  && \
    rm go1.23.7.linux-amd64.tar.gz
RUN /usr/local/go/bin/go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.6

ENV PATH="/usr/local/go/bin:$PATH"
# Set GOPATH and update PATH
RUN mkdir -p /go \
    && echo 'export GOPATH=/go' >> /etc/profile \
    && echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> /etc/profile

ENV GOPATH=/go
ENV PATH="$PATH:$GOPATH/bin"
ENV PATH="$PATH:/root/go/bin/"


#ENV PB_REL="https://github.com/protocolbuffers/protobuf/releases"
#ENV PROTOC_VERSION=30.2
#
## Install required dependencies
#RUN apt update && apt install -y  curl autoconf automake libtool curl make g++ unzip python3 python3-pip python3.11-venv && \
#    curl -LO $PB_REL/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip && \
#    unzip protoc-${PROTOC_VERSION}-linux-x86_64.zip -d protoc-30.2 && \
#    mv protoc-30.2/bin/protoc /usr/local/bin/ && \
#    mv protoc-30.2/include/* /usr/local/include/
#
#RUN python3 -m pip install --user --break-system-packages grpcio-tools && python3 -m venv myenv
#RUN source myenv/bin/activate && python3 -m pip install grpcio && apt install -y python3-grpcio python3-grpc-tools
#
#
#
## Set working directory
#WORKDIR /proto
#
## Define entrypoint to generate code
#ENTRYPOINT ["/bin/sh", "-c", "protoc --proto_path=/proto --python_out=/output -I/usr/include/google/protobuf --grpc_out=/output /proto/* "]


