FROM node:18

RUN apt-get update && \
    apt-get -y install git unzip build-essential autoconf libtool

RUN git clone https://github.com/google/protobuf.git && \
    cd protobuf && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig && \
    make clean && \
    cd .. && \
    rm -r protobuf

WORKDIR /out
RUN npm install grpc_tools_node_protoc_ts --save-dev && \
    ln -s /out/node_modules/.bin/protoc-gen-ts /bin/grpc_tools_node_protoc

ENTRYPOINT ["protoc"]
CMD []
