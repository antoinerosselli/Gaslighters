extends Node3D
@onready var animation_player = $AnimationPlayer

func _ready():
	get_tree().paused = false
	animation_player.play("Phase1")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Phase1":
		Tools.start_transition("End", load("res://Scene/menu3D.tscn") as PackedScene)
