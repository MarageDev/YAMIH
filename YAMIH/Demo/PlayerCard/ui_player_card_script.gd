extends Control
class_name  C_PlayerCard

@onready var player_name: Label = %PlayerName
@onready var player_index: Label = %PlayerIndex
@onready var input: Label = %Input
@onready var action_name: Label = %ActionName
@onready var registered_action_name: Label = %RegisteredActionName

var pressed_input : C_ModularInput = null
var associated_player : C_PlayerInputHandler = null

func _update_action_text():
	if not pressed_input or not associated_player: return

	input.text = pressed_input.input.as_text()
	registered_action_name.text = str(pressed_input.action_name,"_",associated_player.PlayerIndex)
	action_name.text = pressed_input.action_name

func _update_player_text():
	if not associated_player : return
	
	player_name.text = associated_player.PlayerName
	player_index.text = str(associated_player.PlayerIndex)

func _input(event):
	for Action:StringName in InputMap.get_actions(): # get all input map actions
		if event.is_action_pressed(Action) and !Action.begins_with("ui"): # retrieve pressed action and exlcude "ui" actions
			if associated_player.PlayerIndex == int(Action.split("_")[1]): # if the input in input map suffix is equal to this card player index
				for j:C_ModularInput in associated_player.Inputs: 
					if j.action_name == Action.split("_")[0] : # if the input name is equal to the registered one in the input map
						pressed_input = j
						_update_action_text()
