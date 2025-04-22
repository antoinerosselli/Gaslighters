extends Node
@onready var animation_player = $"../AnimationPlayer"

func _ready():
	animation_player.play("rencontredu3emetype")
