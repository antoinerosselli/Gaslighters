extends Node2D
@onready var button = $Control/Button

func _ready():
	get_tree().paused = false
	print("in demo end")
	print(Input.get_mouse_mode())
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print(Input.get_mouse_mode())

func _on_button_pressed():
	print("go to menu")
	get_tree().change_scene_to_file("res://Scene/menu3D.tscn") 
