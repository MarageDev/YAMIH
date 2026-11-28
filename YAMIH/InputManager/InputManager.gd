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
