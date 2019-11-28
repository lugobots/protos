# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [physics.proto](#physics.proto)
    - [Point](#lugo.Point)
    - [Vector](#lugo.Vector)
    - [Velocity](#lugo.Velocity)
  
  
  
  

- [server.proto](#server.proto)
    - [Ball](#lugo.Ball)
    - [Catch](#lugo.Catch)
    - [GameSnapshot](#lugo.GameSnapshot)
    - [JoinRequest](#lugo.JoinRequest)
    - [Jump](#lugo.Jump)
    - [Kick](#lugo.Kick)
    - [Move](#lugo.Move)
    - [Order](#lugo.Order)
    - [OrderResponse](#lugo.OrderResponse)
    - [OrderSet](#lugo.OrderSet)
    - [Player](#lugo.Player)
    - [Team](#lugo.Team)
  
    - [GameSnapshot.Phase](#lugo.GameSnapshot.Phase)
    - [OrderResponse.StatusCode](#lugo.OrderResponse.StatusCode)
    - [Team.Side](#lugo.Team.Side)
  
  
    - [Game](#lugo.Game)
  

- [Scalar Value Types](#scalar-value-types)



<a name="physics.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## physics.proto



<a name="lugo.Point"></a>

### Point
Point represents one position on the cartesian plan of the game field.
The coordinates start at the left bottom corner from the top view .


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| X | [int32](#int32) |  | Distance from the Y axis to right. |
| Y | [int32](#int32) |  | Distance from the X axis to up. |






<a name="lugo.Vector"></a>

### Vector
Vector represent one direction on a cartesian plan


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| X | [double](#double) |  | Coordinate X to define the vector direction. |
| Y | [double](#double) |  | Coordinate Y to define the vector direction. |






<a name="lugo.Velocity"></a>

### Velocity
Velocity is a tuple with the direction (a vector) an a speed (float) values.
It defines the velocity of an object.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| direction | [Vector](#lugo.Vector) |  | Direction is a normalised vector that indicates the element direction |
| speed | [double](#double) |  | Speed of the element. |





 

 

 

 



<a name="server.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## server.proto



<a name="lugo.Ball"></a>

### Ball
Stores all ball attributes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Position | [Point](#lugo.Point) |  | Current position |
| velocity | [Velocity](#lugo.Velocity) |  | Current velocity. It will be the exactly same velocity as the ball holder when a player is holding it. |
| holder | [Player](#lugo.Player) |  | Player that is currently holding the ball. Null if the ball is not holden. |






<a name="lugo.Catch"></a>

### Catch
Order to try to catch the ball. The player can only catch the ball when the player is touching the ball.
Only one catching order can be executed in a turn. So, if more than one player try to catch the ball in the same
turn, the first processed catch order will succeed, and the next ones will fail.






<a name="lugo.GameSnapshot"></a>

### GameSnapshot
GameSnapshot stores all game elements data.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| state | [GameSnapshot.Phase](#lugo.GameSnapshot.Phase) |  | The game state defines which phase the game is. The phase determine what the server is doing, are going to do, or what it is waiting for. |
| turn | [uint32](#uint32) |  | Turns counter. It starts from 1, but before the match starts, it may be zero. |
| home_team | [Team](#lugo.Team) |  | Store the home team elements. |
| away_team | [Team](#lugo.Team) |  | Store the away team elements. |
| ball | [Ball](#lugo.Ball) |  | Store the ball element. |






<a name="lugo.JoinRequest"></a>

### JoinRequest
JoinRequest define the player configuration to the game.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| token | [string](#string) |  | Only used in official matches to guarantee that only one process will assume that player position (team and number). The bot process will receive this token as an argument, and must send it to the server in this message. |
| protocol_version | [string](#string) |  | Identifies the protocol version of the bot. |
| team_side | [Team.Side](#lugo.Team.Side) |  | Identify the bot&#39;s team side (Team_Home or Team_Away) |
| number | [uint32](#uint32) |  | Player&#39;s number 1-11 |
| init_position | [Point](#lugo.Point) |  | Position where the player must be set at &#34;GetReady&#34; state (at beginning of the match or after a goal) |






<a name="lugo.Jump"></a>

### Jump
Changes the goalkeepers velocity in a higher speed.
The goalkeepers may move kicker than other players when they jump, however the jump movement cannot be interrupted
after triggered. (read specs to find out the number of turns the jump lasts)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| velocity | [Velocity](#lugo.Velocity) |  | Goalkeeper&#39;s velocity during the jump. |






<a name="lugo.Kick"></a>

### Kick
The kick order is only executed by the ball holder, and it is processed immediately.
Important: The kick velocity is summed to the current ball velocity.
The kick speed will suffer a power reduction proportionally to the player direction when the kick is not in the
same direction of the player direction. The reduction is calculated based on the angle with the player direction
using the formula `SpeedReducerFactor = 0.5 &#43; (0.5 * ((180 - ang) / 180))`
In summary, the speed will by reduced proportionally to the angle from 100% at 0 degrees until the limit of
50% at 180 degrees.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| velocity | [Velocity](#lugo.Velocity) |  | Kick velocity (it won&#39;t be necessarily the final ball velocity) |






<a name="lugo.Move"></a>

### Move
Order to ask the server to change the player velocity (direction and speed).
This order replaces the current player velocity, and the new velocity attribute will be immediately processed
in that turn. There is a limit speed to the player. The server will cap the velocity if the request is higher than
the limit.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| velocity | [Velocity](#lugo.Velocity) |  | The nex Velocity |






<a name="lugo.Order"></a>

### Order
Order to the game server. To be sent by players during the Listening phase.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| move | [Move](#lugo.Move) |  |  |
| catch | [Catch](#lugo.Catch) |  |  |
| kick | [Kick](#lugo.Kick) |  |  |
| jump | [Jump](#lugo.Jump) |  |  |






<a name="lugo.OrderResponse"></a>

### OrderResponse
Message sent to the player as a response after sending a order set to the the server.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| code | [OrderResponse.StatusCode](#lugo.OrderResponse.StatusCode) |  | Define if the order will be correctly processed. |
| details | [string](#string) |  | String message used for debugging proposes. |






<a name="lugo.OrderSet"></a>

### OrderSet
Message containing the orders the player want to send to the server in that turn.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| turn | [uint32](#uint32) |  | Turn which this order set should be processed at. |
| orders | [Order](#lugo.Order) | repeated | List of orders in the expected order of execution |
| debug_message | [string](#string) |  | String message used for debugging proposes. |






<a name="lugo.Player"></a>

### Player
Stores all player attributes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| number | [uint32](#uint32) |  | Number of this player in its team (1-11) |
| Position | [Point](#lugo.Point) |  | Current player position |
| velocity | [Velocity](#lugo.Velocity) |  | Current player velocity |
| team_side | [Team.Side](#lugo.Team.Side) |  | Team side which its playing in (it&#39;s used to speed up some readings since the player element will be in a list of players of a team) |
| init_position | [Point](#lugo.Point) |  | Default position when it&#39;s position is reset |






<a name="lugo.Team"></a>

### Team
Stores all team elements and data.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| players | [Player](#lugo.Player) | repeated | List of player in the team |
| Name | [string](#string) |  | Team name |
| Score | [uint32](#uint32) |  | Team score in the present turn |
| side | [Team.Side](#lugo.Team.Side) |  | Side which the team is playing on. |





 


<a name="lugo.GameSnapshot.Phase"></a>

### GameSnapshot.Phase


| Name | Number | Description |
| ---- | ------ | ----------- |
| WAITING | 0 | The game is waiting for all players be connected. There is a configurable time limit to wait for players. After this limit expires, the match is considered over. |
| GET_READY | 1 | The game resets the players position to start the match or to restart the match after a goal. |
| LISTENING | 2 | The game is waiting for players orders. There is a configurable time window for this phase. After the time limit expires, the server will ignore the missing orders and process the ones it got. (when running on dev mode, the server may allow different behaviours) |
| PLAYING | 3 | The game is executing the players&#39; orders in the same sequence they were gotten. If the ball is NOT been holden, its velocity will be processed first. Otherwise, it position will be updated when the ball holder movement be processed. If there is no movement orders from a player, but it has speed greater than 0, it will be processed after all its orders are processed. Each player orders will be processed in the same sequence they were included in the message (e.g. first move, than kick) The ball kick is processed immediately after the order (the ball position is updated as its new velocity after the kick) |
| OVER | 99 | The game may be over after any phase. It can be over after Waiting if there is no players connected after the time limit for connections It can be over after GetReady or Listening if there is no enough players (e.g. connection lost) And it also can be over after Playing state if that was the last turn of the match. |



<a name="lugo.OrderResponse.StatusCode"></a>

### OrderResponse.StatusCode


| Name | Number | Description |
| ---- | ------ | ----------- |
| SUCCESS | 0 |  |
| UNKNOWN_PLAYER | 1 |  |
| NOT_LISTENING | 2 |  |
| WRONG_TURN | 3 |  |
| OTHER | 99 |  |



<a name="lugo.Team.Side"></a>

### Team.Side


| Name | Number | Description |
| ---- | ------ | ----------- |
| HOME | 0 | Team playing on the left side of field |
| AWAY | 1 | Team playing on the right side of the field |


 

 


<a name="lugo.Game"></a>

### Game
Service provided by the game service to the players (clients).

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| JoinATeam | [JoinRequest](#lugo.JoinRequest) | [GameSnapshot](#lugo.GameSnapshot) stream | JoinATeam allows the player to listen the server during the match. |
| SendOrders | [OrderSet](#lugo.OrderSet) | [OrderResponse](#lugo.OrderResponse) | SendOrders allows the player to send others to the server when the game is on listening state. |

 



## Scalar Value Types

| .proto Type | Notes | C++ Type | Java Type | Python Type |
| ----------- | ----- | -------- | --------- | ----------- |
| <a name="double" /> double |  | double | double | float |
| <a name="float" /> float |  | float | float | float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long |
| <a name="bool" /> bool |  | bool | boolean | boolean |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str |

