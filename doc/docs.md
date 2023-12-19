# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [broadcast.proto](#broadcast-proto)
    - [EventDebugBreakpoint](#lugo-EventDebugBreakpoint)
    - [EventDebugReleased](#lugo-EventDebugReleased)
    - [EventGameOver](#lugo-EventGameOver)
    - [EventGoal](#lugo-EventGoal)
    - [EventLostPlayer](#lugo-EventLostPlayer)
    - [EventNewPlayer](#lugo-EventNewPlayer)
    - [EventStateChange](#lugo-EventStateChange)
    - [GameEvent](#lugo-GameEvent)
    - [GameSetup](#lugo-GameSetup)
    - [StartRequest](#lugo-StartRequest)
    - [TeamColor](#lugo-TeamColor)
    - [TeamColors](#lugo-TeamColors)
    - [TeamSettings](#lugo-TeamSettings)
    - [WatcherRequest](#lugo-WatcherRequest)
  
    - [EventDebugBreakpoint.Breakpoint](#lugo-EventDebugBreakpoint-Breakpoint)
    - [GameSetup.ListeningMode](#lugo-GameSetup-ListeningMode)
    - [GameSetup.StartingMode](#lugo-GameSetup-StartingMode)
  
    - [Broadcast](#lugo-Broadcast)
  
- [health.proto](#health-proto)
    - [HealthCheckRequest](#grpc-health-v1-HealthCheckRequest)
    - [HealthCheckResponse](#grpc-health-v1-HealthCheckResponse)
  
    - [HealthCheckResponse.ServingStatus](#grpc-health-v1-HealthCheckResponse-ServingStatus)
  
    - [Health](#grpc-health-v1-Health)
  
- [physics.proto](#physics-proto)
    - [Point](#lugo-Point)
    - [Vector](#lugo-Vector)
    - [Velocity](#lugo-Velocity)
  
- [remote.proto](#remote-proto)
    - [BallProperties](#lugo-BallProperties)
    - [CommandResponse](#lugo-CommandResponse)
    - [GameProperties](#lugo-GameProperties)
    - [NextOrderRequest](#lugo-NextOrderRequest)
    - [NextTurnRequest](#lugo-NextTurnRequest)
    - [PauseResumeRequest](#lugo-PauseResumeRequest)
    - [PlayerProperties](#lugo-PlayerProperties)
    - [ResumeListeningRequest](#lugo-ResumeListeningRequest)
    - [ResumeListeningResponse](#lugo-ResumeListeningResponse)
  
    - [CommandResponse.StatusCode](#lugo-CommandResponse-StatusCode)
  
    - [Remote](#lugo-Remote)
  
- [server.proto](#server-proto)
    - [Ball](#lugo-Ball)
    - [Catch](#lugo-Catch)
    - [GameSnapshot](#lugo-GameSnapshot)
    - [JoinRequest](#lugo-JoinRequest)
    - [Jump](#lugo-Jump)
    - [Kick](#lugo-Kick)
    - [Move](#lugo-Move)
    - [Order](#lugo-Order)
    - [OrderResponse](#lugo-OrderResponse)
    - [OrderSet](#lugo-OrderSet)
    - [Player](#lugo-Player)
    - [ShotClock](#lugo-ShotClock)
    - [Team](#lugo-Team)
  
    - [GameSnapshot.State](#lugo-GameSnapshot-State)
    - [OrderResponse.StatusCode](#lugo-OrderResponse-StatusCode)
    - [Team.Side](#lugo-Team-Side)
  
    - [Game](#lugo-Game)
  
- [Scalar Value Types](#scalar-value-types)



<a name="broadcast-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## broadcast.proto



<a name="lugo-EventDebugBreakpoint"></a>

### EventDebugBreakpoint
(only available dev mode) Represents the event of having a breakpoint reached.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| breakpoint | [EventDebugBreakpoint.Breakpoint](#lugo-EventDebugBreakpoint-Breakpoint) |  | Type of the breakpoint reached. |






<a name="lugo-EventDebugReleased"></a>

### EventDebugReleased
(only available dev mode) Represents the event of having a breakpoint released.






<a name="lugo-EventGameOver"></a>

### EventGameOver
Represents the event of having the game ended.






<a name="lugo-EventGoal"></a>

### EventGoal
Represents the event of having a goal during the match


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| side | [Team.Side](#lugo-Team-Side) |  | Side of the team that changed the score.

@todo implementing the player who scored. |






<a name="lugo-EventLostPlayer"></a>

### EventLostPlayer
Represents the event of having a player disconnected from the game.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| player | [Player](#lugo-Player) |  | Player that has disconnected from the game. |






<a name="lugo-EventNewPlayer"></a>

### EventNewPlayer
Represents the event of having a new player connected to the game.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| player | [Player](#lugo-Player) |  | Player that has connected to the game. |






<a name="lugo-EventStateChange"></a>

### EventStateChange
Represents the event of having the game state changed (e.g. from Waiting to GetReady).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| previous_state | [GameSnapshot.State](#lugo-GameSnapshot-State) |  | State of the game before the event. |
| new_state | [GameSnapshot.State](#lugo-GameSnapshot-State) |  | State of the game after the event. |






<a name="lugo-GameEvent"></a>

### GameEvent
Brings the game snapshot and the event in a specialised format.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| game_snapshot | [GameSnapshot](#lugo-GameSnapshot) |  | Game snapshot after the event has happened. |
| new_player | [EventNewPlayer](#lugo-EventNewPlayer) |  |  |
| lost_player | [EventLostPlayer](#lugo-EventLostPlayer) |  |  |
| state_change | [EventStateChange](#lugo-EventStateChange) |  |  |
| goal | [EventGoal](#lugo-EventGoal) |  |  |
| game_over | [EventGameOver](#lugo-EventGameOver) |  |  |
| breakpoint | [EventDebugBreakpoint](#lugo-EventDebugBreakpoint) |  |  |
| debug_released | [EventDebugReleased](#lugo-EventDebugReleased) |  |  |






<a name="lugo-GameSetup"></a>

### GameSetup



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| protocol_version | [string](#string) |  | Defines the communication protocol version between the players and the game server. The players also inform to the server what protocol they will use. If incompatible, the server will reject the player. |
| dev_mode | [bool](#bool) |  |  |
| start_mode | [GameSetup.StartingMode](#lugo-GameSetup-StartingMode) |  |  |
| listening_mode | [GameSetup.ListeningMode](#lugo-GameSetup-ListeningMode) |  |  |
| listening_duration | [uint32](#uint32) |  | in milliseconds |
| game_duration | [uint32](#uint32) |  |  |
| home_team | [TeamSettings](#lugo-TeamSettings) |  |  |
| away_team | [TeamSettings](#lugo-TeamSettings) |  |  |






<a name="lugo-StartRequest"></a>

### StartRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| watcher_uuid | [string](#string) |  | Not used on localhost |






<a name="lugo-TeamColor"></a>

### TeamColor



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| red | [uint32](#uint32) |  |  |
| green | [uint32](#uint32) |  |  |
| blue | [uint32](#uint32) |  |  |






<a name="lugo-TeamColors"></a>

### TeamColors



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| primary | [TeamColor](#lugo-TeamColor) |  |  |
| secondary | [TeamColor](#lugo-TeamColor) |  |  |






<a name="lugo-TeamSettings"></a>

### TeamSettings



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |
| avatar | [string](#string) |  |  |
| colors | [TeamColors](#lugo-TeamColors) |  |  |






<a name="lugo-WatcherRequest"></a>

### WatcherRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| uuid | [string](#string) |  | Not used on localhost |





 


<a name="lugo-EventDebugBreakpoint-Breakpoint"></a>

### EventDebugBreakpoint.Breakpoint


| Name | Number | Description |
| ---- | ------ | ----------- |
| ORDERS | 0 | Breakpoint that breaks the game before each player orders set be processed during the &#34;Playing&#34; state Each player&#39;s order set will be processed at once, so the breakpoint controls the process based on players, not on orders. |
| TURN | 1 | Breakpoint that breaks the game before each player turn be processed during the &#34;Playing&#34; state |



<a name="lugo-GameSetup-ListeningMode"></a>

### GameSetup.ListeningMode


| Name | Number | Description |
| ---- | ------ | ----------- |
| TIMER | 0 | respect the timer defined by listening duration |
| RUSH | 1 | immediately after all orders |
| REMOTE | 2 | wait external remote control (dev only) |



<a name="lugo-GameSetup-StartingMode"></a>

### GameSetup.StartingMode


| Name | Number | Description |
| ---- | ------ | ----------- |
| NO_WAIT | 0 | start the game as soon as all players are connected |
| WAIT | 1 | do not start until the master watcher request (gRPC call to Broadcast service) |


 

 


<a name="lugo-Broadcast"></a>

### Broadcast
Service to be consumed by clients (e.g. frontend, app, etc) to watch the match.
The game server implements a Broadcast service. This service may help you to control or watch the game during
training sessions.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| OnEvent | [WatcherRequest](#lugo-WatcherRequest) | [GameEvent](#lugo-GameEvent) stream | Keep an open stream that publish all important events in the match. |
| GetGameSetup | [WatcherRequest](#lugo-WatcherRequest) | [GameSetup](#lugo-GameSetup) | Returns the game setup configuration. |
| StartGame | [StartRequest](#lugo-StartRequest) | [GameSetup](#lugo-GameSetup) | StartGame allows the master watcher to start the match. See the Game Server starting mode to understand how it works. |

 



<a name="health-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## health.proto



<a name="grpc-health-v1-HealthCheckRequest"></a>

### HealthCheckRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| service | [string](#string) |  |  |






<a name="grpc-health-v1-HealthCheckResponse"></a>

### HealthCheckResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [HealthCheckResponse.ServingStatus](#grpc-health-v1-HealthCheckResponse-ServingStatus) |  |  |





 


<a name="grpc-health-v1-HealthCheckResponse-ServingStatus"></a>

### HealthCheckResponse.ServingStatus


| Name | Number | Description |
| ---- | ------ | ----------- |
| UNKNOWN | 0 |  |
| SERVING | 1 |  |
| NOT_SERVING | 2 |  |
| SERVICE_UNKNOWN | 3 | Used only by the Watch method. |


 

 


<a name="grpc-health-v1-Health"></a>

### Health


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Check | [HealthCheckRequest](#grpc-health-v1-HealthCheckRequest) | [HealthCheckResponse](#grpc-health-v1-HealthCheckResponse) |  |
| Watch | [HealthCheckRequest](#grpc-health-v1-HealthCheckRequest) | [HealthCheckResponse](#grpc-health-v1-HealthCheckResponse) stream |  |

 



<a name="physics-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## physics.proto



<a name="lugo-Point"></a>

### Point
Point represents one position on the cartesian plan of the game field.
The coordinates start at the left bottom corner from the top view .


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| x | [int32](#int32) |  | Distance from the Y axis to right. |
| y | [int32](#int32) |  | Distance from the X axis to up. |






<a name="lugo-Vector"></a>

### Vector
Vector represent one direction on a cartesian plan


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| x | [double](#double) |  | Coordinate X to define the vector direction. |
| y | [double](#double) |  | Coordinate Y to define the vector direction. |






<a name="lugo-Velocity"></a>

### Velocity
Velocity is a tuple with the direction (a vector) an a speed (float) values.
It defines the velocity of an object.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| direction | [Vector](#lugo-Vector) |  | Direction is a normalised vector that indicates the element direction |
| speed | [double](#double) |  | Speed of the element. |





 

 

 

 



<a name="remote-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## remote.proto



<a name="lugo-BallProperties"></a>

### BallProperties



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| position | [Point](#lugo-Point) |  |  |
| velocity | [Velocity](#lugo-Velocity) |  |  |
| holder | [Player](#lugo-Player) |  |  |






<a name="lugo-CommandResponse"></a>

### CommandResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| code | [CommandResponse.StatusCode](#lugo-CommandResponse-StatusCode) |  |  |
| game_snapshot | [GameSnapshot](#lugo-GameSnapshot) |  |  |
| details | [string](#string) |  |  |






<a name="lugo-GameProperties"></a>

### GameProperties



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| turn | [uint32](#uint32) |  |  |
| home_score | [uint32](#uint32) |  |  |
| away_score | [uint32](#uint32) |  |  |
| frame_interval | [int64](#int64) |  |  |
| shot_clock | [ShotClock](#lugo-ShotClock) |  |  |






<a name="lugo-NextOrderRequest"></a>

### NextOrderRequest







<a name="lugo-NextTurnRequest"></a>

### NextTurnRequest







<a name="lugo-PauseResumeRequest"></a>

### PauseResumeRequest







<a name="lugo-PlayerProperties"></a>

### PlayerProperties



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| side | [Team.Side](#lugo-Team-Side) |  |  |
| number | [uint32](#uint32) |  |  |
| position | [Point](#lugo-Point) |  |  |
| velocity | [Velocity](#lugo-Velocity) |  |  |






<a name="lugo-ResumeListeningRequest"></a>

### ResumeListeningRequest







<a name="lugo-ResumeListeningResponse"></a>

### ResumeListeningResponse






 


<a name="lugo-CommandResponse-StatusCode"></a>

### CommandResponse.StatusCode


| Name | Number | Description |
| ---- | ------ | ----------- |
| SUCCESS | 0 |  |
| INVALID_VALUE | 1 |  |
| DEADLINE_EXCEEDED | 2 |  |
| OTHER | 99 |  |


 

 


<a name="lugo-Remote"></a>

### Remote
The game server implements a Remote service that allows you to control the game flow.
This service may help you to control or watch the game during training sessions.
The game server only offers this service on debug mode on.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| PauseOrResume | [PauseResumeRequest](#lugo-PauseResumeRequest) | [CommandResponse](#lugo-CommandResponse) |  |
| NextTurn | [NextTurnRequest](#lugo-NextTurnRequest) | [CommandResponse](#lugo-CommandResponse) |  |
| NextOrder | [NextOrderRequest](#lugo-NextOrderRequest) | [CommandResponse](#lugo-CommandResponse) |  |
| SetBallProperties | [BallProperties](#lugo-BallProperties) | [CommandResponse](#lugo-CommandResponse) |  |
| SetPlayerProperties | [PlayerProperties](#lugo-PlayerProperties) | [CommandResponse](#lugo-CommandResponse) |  |
| SetGameProperties | [GameProperties](#lugo-GameProperties) | [CommandResponse](#lugo-CommandResponse) |  |
| ResumeListeningPhase | [ResumeListeningRequest](#lugo-ResumeListeningRequest) | [ResumeListeningResponse](#lugo-ResumeListeningResponse) |  |

 



<a name="server-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## server.proto



<a name="lugo-Ball"></a>

### Ball



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| position | [Point](#lugo-Point) |  |  |
| velocity | [Velocity](#lugo-Velocity) |  |  |
| holder | [Player](#lugo-Player) |  |  |






<a name="lugo-Catch"></a>

### Catch







<a name="lugo-GameSnapshot"></a>

### GameSnapshot



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| state | [GameSnapshot.State](#lugo-GameSnapshot-State) |  |  |
| turn | [uint32](#uint32) |  |  |
| home_team | [Team](#lugo-Team) |  |  |
| away_team | [Team](#lugo-Team) |  |  |
| ball | [Ball](#lugo-Ball) |  |  |
| turns_ball_in_goal_zone | [uint32](#uint32) |  |  |
| shot_clock | [ShotClock](#lugo-ShotClock) |  |  |






<a name="lugo-JoinRequest"></a>

### JoinRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| token | [string](#string) |  |  |
| protocol_version | [string](#string) |  |  |
| team_side | [Team.Side](#lugo-Team-Side) |  |  |
| number | [uint32](#uint32) |  |  |
| init_position | [Point](#lugo-Point) |  |  |






<a name="lugo-Jump"></a>

### Jump



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| velocity | [Velocity](#lugo-Velocity) |  |  |






<a name="lugo-Kick"></a>

### Kick



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| velocity | [Velocity](#lugo-Velocity) |  |  |






<a name="lugo-Move"></a>

### Move



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| velocity | [Velocity](#lugo-Velocity) |  |  |






<a name="lugo-Order"></a>

### Order



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| move | [Move](#lugo-Move) |  |  |
| catch | [Catch](#lugo-Catch) |  |  |
| kick | [Kick](#lugo-Kick) |  |  |
| jump | [Jump](#lugo-Jump) |  |  |






<a name="lugo-OrderResponse"></a>

### OrderResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| code | [OrderResponse.StatusCode](#lugo-OrderResponse-StatusCode) |  |  |
| details | [string](#string) |  |  |






<a name="lugo-OrderSet"></a>

### OrderSet



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| turn | [uint32](#uint32) |  |  |
| orders | [Order](#lugo-Order) | repeated |  |
| debug_message | [string](#string) |  |  |






<a name="lugo-Player"></a>

### Player



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| number | [uint32](#uint32) |  |  |
| position | [Point](#lugo-Point) |  |  |
| velocity | [Velocity](#lugo-Velocity) |  |  |
| team_side | [Team.Side](#lugo-Team-Side) |  |  |
| init_position | [Point](#lugo-Point) |  |  |
| is_jumping | [bool](#bool) |  | indicates the the player is jumping (goalkeepers only) |






<a name="lugo-ShotClock"></a>

### ShotClock



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| team_side | [Team.Side](#lugo-Team-Side) |  |  |
| remaining_turns | [uint32](#uint32) |  |  |






<a name="lugo-Team"></a>

### Team



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| players | [Player](#lugo-Player) | repeated |  |
| name | [string](#string) |  |  |
| score | [uint32](#uint32) |  |  |
| side | [Team.Side](#lugo-Team-Side) |  |  |





 


<a name="lugo-GameSnapshot-State"></a>

### GameSnapshot.State


| Name | Number | Description |
| ---- | ------ | ----------- |
| WAITING | 0 |  |
| GET_READY | 1 |  |
| LISTENING | 2 |  |
| PLAYING | 3 |  |
| SHIFTING | 4 |  |
| OVER | 99 |  |



<a name="lugo-OrderResponse-StatusCode"></a>

### OrderResponse.StatusCode


| Name | Number | Description |
| ---- | ------ | ----------- |
| SUCCESS | 0 |  |
| UNKNOWN_PLAYER | 1 |  |
| NOT_LISTENING | 2 |  |
| WRONG_TURN | 3 |  |
| OTHER | 99 |  |



<a name="lugo-Team-Side"></a>

### Team.Side


| Name | Number | Description |
| ---- | ------ | ----------- |
| HOME | 0 |  |
| AWAY | 1 |  |


 

 


<a name="lugo-Game"></a>

### Game


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| JoinATeam | [JoinRequest](#lugo-JoinRequest) | [GameSnapshot](#lugo-GameSnapshot) stream |  |
| SendOrders | [OrderSet](#lugo-OrderSet) | [OrderResponse](#lugo-OrderResponse) |  |

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

