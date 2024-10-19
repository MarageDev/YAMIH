extends Control

@onready var label_name: Label = $VBoxContainer/Label2
@onready var label_state: Label = $VBoxContainer/Label4

func _process(delta: float) -> void:
	if Input.is_action_just_released("hello"):
		label_name.text = "aaaaaa"
