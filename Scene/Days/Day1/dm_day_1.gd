extends Node

@export var DANGER_LEVEL: int
@onready var depots = []

func _ready():
	depots = get_tree().get_nodes_in_group("depot")
	activate_depots()

func activate_depots():
	var available_depots = depots.filter(func(depot): return !depot.activation) 
	if available_depots.is_empty():
		return 
	available_depots.shuffle() 
	for i in range(min(DANGER_LEVEL, available_depots.size())):
		available_depots[i].activation = true
