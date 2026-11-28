<h1 align="center">YAMIH</h1>

YAMIH *( Yet Another Multiplayer Input Handler )* is an attempt at creating a more modular approach to Godot's Input system, especially for local multiplayer games. It can handle keyboard inputs, controllers ( and probably also all the other inputs possible in Godot but I couldn't try the other ones ).

It can support at least 6 players ( tested ), but it can probably support even more players as long as you have enough unique inputs.

> Godot 4.3 - 4.8 

<img width="1146" height="642" alt="image" src="https://github.com/user-attachments/assets/8ca67330-b0b4-41e2-a068-f576ce50f9a9" />


<h2>Presentation</h2>

<h3>Input</h3>

```gdscript
extends Resource
class_name C_ModularInput

@export var action_name:String
@export var input:InputEvent
```
- `action_name` is used later in the `InputManager` to add this action ( once formatted ) to the designated `InputMap`.
- `input` is used to specify which input you want to capture for this action ( key, joypad ... ).
<h3>PlayerInputHandler</h3>

```gdscript
extends Resource
class_name C_PlayerInputHandler

@export var PlayerIndex:int = 0
@export var PlayerName:String = "Player"
@export var Inputs: Array[C_ModularInput]
```
- `Inputs` is used to store all the actions possible for this player.
- `PlayerIndex` must be different for each players.
> `PlayerName` has no real use besides the demo.

<h3>InputManager</h3>

```gdscript
extends Node
class_name C_InputManager

@export var Players:Array[C_PlayerInputHandler]
var Actions:Array[String]

func _ready():
	update_all_actions()

func write_actions_to_input_map(Player:C_PlayerInputHandler):
	for InputRef in Player.Inputs:
		var formated_action_name:String = str(InputRef.action_name,"_",Player.PlayerIndex)
		InputMap.add_action(formated_action_name)
		InputMap.action_add_event(formated_action_name,InputRef.input)
		Actions.append(formated_action_name)

func update_all_actions():
	for i:C_PlayerInputHandler in Players:
		write_actions_to_input_map(i)

func remap_action(input_action_name:String, input_action_event:InputEvent, remapping_input:InputEvent):
	if InputMap.has_action(input_action_name) : 
		InputMap.action_erase_event(input_action_name, input_action_event)
	InputMap.action_add_event(input_action_name, remapping_input)
	
	# Update the Input array from the player input handler
	for input:C_ModularInput in Players[int(input_action_name.split("_")[1])].Inputs : 
		if input.action_name == str(input_action_name.split("_")[0]):
			input.input = remapping_input
```
- `Players` stores all the players with their associated actions ( class of `C_PlayerInputHandler`, see above ).

- `write_actions_to_input_map` adds every `Inputs` stored to the designated `InputMapRef` as `[Action Name]_[Player Index]`.

- `update_all_actions` is used if you plan to add/remove another player while playing.

- `remap_action` is used when remapping the input event of an action by a new one (see demo)

<h2>Demo</h2>
<h3>Principle</h3>

It adds `UI_PlayerCard.tscn` for each registered players in the `InputManager.tscn` node referenced as an export, and display the action, name, player index on the according card. There's also a sub-demo for input remapping.
It's mainly here to verify that everything works correctly.

![image](https://github.com/user-attachments/assets/f5494e0d-4745-4ec3-8507-7be287239a1f)
