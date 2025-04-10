extends Node3D
@onready var animation_player = $AnimationPlayer

func _ready():
	get_tree().paused = false
	animation_player.play("come_to_me")
