extends Node2D
@onready var button = $Control/Button

func _ready():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scene/menu3D.tscn") 
