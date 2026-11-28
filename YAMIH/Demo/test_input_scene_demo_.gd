extends Control

@export var InputManager:C_InputManager

# Multiplayer

@onready var flow_container: FlowContainer = $MarginContainer_PlayerInputs/FlowContainer

# Input remap example

@onready var input_remap_card: C_InputRemap = $MarginContainer_Remap/InputRemapCard
@onready var label_remap_instruction: Label = $Label_RemapInstruction

var last_pressed_input_name : String
var last_pressed_input_event : InputEvent

func _ready() -> void:
	var player_indexes:Array[int]
	
	for Action in InputMap.get_actions():
		if !player_indexes.has(int(Action.split("_")[1])) : player_indexes.append(int(Action.split("_")[1]))
	
	for i in range(player_indexes.max() + 1):
		var new_player_card:C_PlayerCard = preload("res://YAMIH/Demo/PlayerCard/UI_PlayerCard.tscn").instantiate()
		flow_container.add_child(new_player_card)
		new_player_card.associated_player = InputManager.Players[i]
		new_player_card._update_player_text()

func _process(delta: float) -> void:
	label_remap_instruction.visible = input_remap_card.is_remapping

func _input(event:InputEvent):
	# Simple input remap : when button pressed, wait for new input, and replace last input with this one
	for Action:StringName in InputMap.get_actions(): # get all input map actions
		if event.is_action_pressed(Action) and !Action.begins_with("ui"): # retrieve pressed action and exlcude "ui" actions
			last_pressed_input_event = event
			last_pressed_input_name = Action
			input_remap_card._update_text(last_pressed_input_name,"")
			
	if input_remap_card.is_remapping : 
		if event is not InputEventMouse :
			input_remap_card._update_text(last_pressed_input_name, event.as_text())
			InputManager.remap_action(last_pressed_input_name,last_pressed_input_event,event)
			input_remap_card.is_remapping = false
