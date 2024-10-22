extends Node
class_name C_InputManager

@export var Players:Array[C_PlayerInputHandler]
var Actions:Array[String]

func _ready():
	for i:C_PlayerInputHandler in Players:
		write_actions_to_input_map(i,InputMap)

func write_actions_to_input_map(Player:C_PlayerInputHandler,InputMapRef:Object = InputMap):
	for InputRef in Player.Inputs:
		var formated_action_name:String = str(InputRef.action_name,"_",Player.PlayerIndex)
		InputMap.add_action(formated_action_name)
		InputMap.action_add_event(formated_action_name,InputRef.input)
		Actions.append(formated_action_name)
