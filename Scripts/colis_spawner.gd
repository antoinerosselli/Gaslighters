extends Marker3D

@export var colis:PackedScene

func drop_the_colis():
	var ncolis = colis.instantiate()
	var pos_spawn = self.global_position
	var scene = get_tree().get_first_node_in_group("scene")
	ncolis.global_position = pos_spawn
	scene.add_child(ncolis)
