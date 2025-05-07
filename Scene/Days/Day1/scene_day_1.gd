extends Node3D

func _ready():
	get_tree().paused = false
	Data.set_food(3)
	Data.set_level(1)
	Radio.setValue(0)
