extends Resource
class_name C_PlayerInputHandler


@export var PlayerIndex:int = 0
@export var PlayerName:String = "Player"
@export var Inputs: Array[C_ModularInput]


func attach_key_binding(InputRef: C_ModularInput, InputMapUsed: Object = InputMap):
	InputMapUsed.add_action(InputRef.action_name)
	InputMapUsed.action_add_event(InputRef.action_name, InputRef.key)
func _ready() -> void:
	for input in Inputs:
		print(input.action_name)
		attach_key_binding(input)
	for i:String in InputMap.get_actions():
		if !i.begins_with("ui"):
			print(i)
