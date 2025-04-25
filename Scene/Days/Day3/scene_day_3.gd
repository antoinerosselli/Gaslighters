extends Node3D

func _ready():
	get_tree().paused = false
	Data.set_level(3)
	Tools.set_elec(1)
	#var codesr = get_tree().get_first_node_in_group("codesr")
	#codesr.activate = false
