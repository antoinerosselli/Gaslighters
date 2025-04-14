extends Node3D

func _ready():
	get_tree().paused = false
	Data.set_level(4)
	UniqueTrait.elec = true
	Tools.set_elec(60)
	var codesr = get_tree().get_first_node_in_group("codesr")
	codesr.activate = false
