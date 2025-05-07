extends Node3D
@onready var panel = $Camera3D/Control/Panel
@onready var logevent = $Camera3D/Control/Logevent
@onready var souvenirs = $Camera3D/Control/Souvenirs

func _ready():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SteamControl.unlock_achievement("ACH_END_GAME")

func _on_take_suit_pressed():
	panel.visible = true

func _on_let_the_suit_pressed():
	panel.visible = true

func _on_no_pressed():
	panel.visible = false

func _on_yes_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Tools.start_transition("", load("res://Scene/final_days/end_cinema.tscn") as PackedScene)

func _on_logevent_pressed():
	souvenirs.visible = true
