extends Control

@onready var label_name: Label = $VBoxContainer/Label2
@onready var label_state: Label = $VBoxContainer/Label4

func _process(delta: float) -> void:
	if Input.is_action_pressed("Up_1"):
		label_name.text = "aaaaaa"
