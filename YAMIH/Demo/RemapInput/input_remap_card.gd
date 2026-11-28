extends Control
class_name C_InputRemap

var is_remapping:bool = false

@onready var remapping_input_key: Label = %RemappingInputKey
@onready var remapped_action: Label = %RemappedAction

func _on_button_remap_pressed() -> void:
	is_remapping = true

func _update_text(action_name:String, remapping_key:String):
	remapping_input_key.text = remapping_key
	remapped_action.text = action_name
