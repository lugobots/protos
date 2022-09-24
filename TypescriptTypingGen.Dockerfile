FROM node:18

RUN apt-get update && \
    apt-get -y install git unzip build-essential autoconf libtool protobuf-compiler

#RUN git clone https://github.com/google/protobuf.git && \
#    cd protobuf && \
#    ./autogen.sh && \
#    ./configure && \
#    make && \
#    make install && \
#    ldconfig && \
#    make clean && \
#    cd .. && \
#    rm -r protobuf

WORKDIR /out
RUN npm install grpc_tools_node_protoc_ts@5.3.2 --save-dev
RUN npm i -g grpc-tools@1.11.2 --unsafe-perm
RUN npm i -g typescript --unsafe-perm
RUN npm i --unsafe-perm
RUN ln -s /out/node_modules/.bin/protoc-gen-ts /bin/grpc_tools_node_protoc

