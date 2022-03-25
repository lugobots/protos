# Lugo Bots Protobuf 

Welcome to Lugo Bots.

This repository stores the proto files that define the services served by the Lugo Bot's server.

See the auto-generated [Documentation](./doc/docs.md) to learn all services and methods.

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
