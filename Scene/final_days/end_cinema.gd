extends Node3D
@onready var animation_player = $AnimationPlayer
@onready var button = $Camera3D/Control/Button

func _ready():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animation_player.play("Phase1")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Phase1":
		button.visible = true

func _on_button_pressed():
	Tools.start_transition("End", load("res://Scene/menu3D.tscn") as PackedScene)

func _on_button_visibility_changed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
