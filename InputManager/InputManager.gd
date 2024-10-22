extends Node
class_name C_InputManager

@export var PlayerInputs:Array[C_PlayerInputHandler]

func _ready():
	for i:C_PlayerInputHandler in PlayerInputs:
		for InputRef in i.Inputs:
			var formated_action_name:String = str(InputRef.action_name,"_",i.PlayerIndex)
			InputMap.add_action(formated_action_name)
			InputMap.action_add_event(formated_action_name, InputRef.key)
