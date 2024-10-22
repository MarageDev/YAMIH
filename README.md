<h1 align="center">YAMIH</h1>
YAMIH ( Yet Another Multiplayer Input Handler ) is an attempt at creating a more modular approach to Godot's Input system, especially for local multiplayer games.

![image](https://github.com/user-attachments/assets/1596673e-486c-4662-ac36-0b91e848e358)


<h2>Presentation</h2>
<h3>Structure</h3>

![image](https://github.com/user-attachments/assets/8f015195-1db8-4f7e-b799-603a719017ed)

<h4>Input</h4>

```gdscript
extends Resource
class_name C_ModularInput

@export var action_name:String
@export var key:InputEventKey
```
<details><summary><i>In the demo</i></summary>

![image](https://github.com/user-attachments/assets/d53f3a27-d0c2-40a3-b1c5-1ee2bfbfd36e)
 
</details>

<h4>PlayerInputHandler</h4>

```gdscript
extends Resource
class_name C_PlayerInputHandler

@export var PlayerIndex:int = 0
@export var PlayerName:String = "Player"
@export var Inputs: Array[C_ModularInput]
```
`Inputs` is used to store all the actions possible for this player.

<details><summary><i>In the demo</i></summary>

![image](https://github.com/user-attachments/assets/236b09e9-3b77-4840-893a-ad2db60eb7ba)
 
</details>


<h4>InputManager</h4>

```gdscript
extends Node
class_name C_InputManager

@export var Players:Array[C_PlayerInputHandler]

func _ready():
	for i:C_PlayerInputHandler in Players:
		for InputRef in i.Inputs:
			var formated_action_name:String = str(InputRef.action_name,"_",i.PlayerIndex)
			InputMap.add_action(formated_action_name)
			InputMap.action_add_event(formated_action_name, InputRef.key)
```
It adds every `Inputs` stored to the `InputMap` as `[Action Name]_[Player Index]`.
`Players` stores all the players with their associated actions ( class of `C_PlayerInputHandler`, see above ).


<details><summary><i>In the demo</i></summary>

![image](https://github.com/user-attachments/assets/31809176-6423-4c1f-a61c-ee6c5dd5d188)
 
</details>

<h2>Demo</h2>
<h3>Structure</h3>

![image](https://github.com/user-attachments/assets/b8e3065c-232e-4238-9364-b131b76d4f75)

<h3>Principle</h3>

It adds `UI_PlayerCard.tscn` for each registered players in the `InputManager.tscn` node referenced as an export, and display the action, name, player index on the according card.

![image](https://github.com/user-attachments/assets/1596673e-486c-4662-ac36-0b91e848e358)
