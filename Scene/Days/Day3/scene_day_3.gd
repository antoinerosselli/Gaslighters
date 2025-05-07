extends Node3D

func _ready():
	get_tree().paused = false
	Data.set_level(3)
	Tools.set_elec(1)
