extends Node


var p1:ModularInput = preload("res://Player1.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1._attach_binding()
	for i in InputMap.get_actions():
		if !i.begins_with("ui"):print(i)
