# Lugo Bots Protobuf 

Welcome to Lugo Bots.

This repository stores the proto files that define the services served by the Lugo Bot's server.

See the auto-generated [Documentation](./doc/docs.md) to learn all services and methods.

## Generating proto files

The script `generate-protos.sh` will generate the proto files for you in different programming languages.

This script relies on the Docker image `lugobots/proto-gen` to create the proto files from inside a containers, thus
you won't need to install other dependencies in your machine.


## Services served by the Game Server

### Game [See Methods](./doc/docs.md#game)

This service offers the methods that the bots will call to communicate with the Game server. 

You will only need to learn how the Game Server protocol works *if you are implementing a new client or helping with a client*
maintenance. Otherwise, you can only use a client.

###  Broadcast [See Methods](./doc/docs.md#broadcast)

This service offers methods that provide details about what is going on during the game match.

The Broadcast service may be used to observe the game state. So, there are many situations in which those methods can
be used to improve the game experience or create development tools.

As an example, those methods may be used by Machine Learning scripts to observe the game state, or create heatmaps, 
track bot trajectory, etc.

###  Remote [See Methods](./doc/docs.md#remote)

When in *debug mode*, the server will serve the Remove service. This service offers methods to control the game state and flow.
You can pause/resume the game, or even change the elements' position.

The main reason for having this service is to empower Machine Learning developers to create game states 
programmatically and have full control over the game.


# Support to Typescript

The gRPC web tool, which would generate the proto directly to Typescripts, relies on web-based Javascript features, that
are not available on Node environment.

In order to have the Typescript typing, we can use a Typescript generator that only generates the `.d.ts` files.

This project brings a Dockerfile that builds an image to use the TS typing generator.

Build the image with:

`docker build -t ts_typing_maker -f TypescriptTypingGen.Dockerfile .`

And use the image with:

```
docker run -it -v $(pwd):/base ts_typing_maker protoc \
    --plugin=protoc-gen-ts=/bin/grpc_tools_node_protoc \
    --ts_out=/base/proto/js \
    -I /base/src \
    /base/src/*
```

These commands are also included in the `./generate-protos.sh` script.


# Python intellisense support

https://youtrack.jetbrains.com/issue/PY-27111/Please-add-protobuf-autocompletion-support.