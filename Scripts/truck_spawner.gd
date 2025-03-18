extends Marker3D

@export var truck: PackedScene

func truck_spawn():
	var ntruck = truck.instantiate()
	self.add_child(ntruck)
