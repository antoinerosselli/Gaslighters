extends Node3D

@onready var stat_value = $SubViewport/StatValue
@export var name_value:String

func ready():
	stat_value.text = "60" + "%"

func _on_timer_timeout():
	var all_inter = get_tree().get_nodes_in_group("inter")
	var hm_inter:int = 0
	for inter in all_inter:
		if inter.is_on == true:
			hm_inter += 1
	Tools.set_elec((Tools.get_elec() - hm_inter) + 1)
	stat_value.text = str(Tools.get_elec()) + "%"
	hm_inter = 0
