extends Control

@export var InputManager:C_InputManager
@onready var flow_container: FlowContainer = $MarginContainer/FlowContainer
var player_cards:Array[C_PlayerCard]
var max_player_count:int = 0
func _ready() -> void:
	var player_indexes:Array[int]
	for Action in InputMap.get_actions():
		if !player_indexes.has(int(Action.split("_")[1])) : player_indexes.append(int(Action.split("_")[1]))
	max_player_count = player_indexes.max() +1
	for i in range(max_player_count):
		var new_player_card:C_PlayerCard = preload("res://YAMIH/Demo/PlayerCard/UI_PlayerCard.tscn").instantiate()
		flow_container.add_child(new_player_card)
		new_player_card.l_player_name.text = InputManager.Players[i].PlayerName
		new_player_card.l_player_index.text = str(InputManager.Players[i].PlayerIndex)
		player_cards.append(new_player_card)


func _input(event):
	for Action in InputMap.get_actions():
		if event.is_action_pressed(Action) and !Action.begins_with("ui"):
			var player_index:int = int(Action.split("_")[1])
			var pressed_key:String
			var player_name:String
			var action:String = Action.split("_")[0]
			for i:C_PlayerInputHandler in InputManager.Players:
				if i.PlayerIndex == player_index:
					for j:C_ModularInput in i.Inputs:
						if j.action_name == action :
							pressed_key = j.input.as_text()
			for i:C_PlayerCard in player_cards:
				if i.l_player_index.text == str(player_index):
					i.l_registered_action_name.text = Action
					i.l_input.text = pressed_key
					i.l_action_name.text = action
