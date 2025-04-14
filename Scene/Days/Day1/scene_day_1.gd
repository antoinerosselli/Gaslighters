extends Node3D

func _ready():
	get_tree().paused = false
	Data.set_level(1)
	UniqueTrait.elec = true
	Tools.set_elec(60)
