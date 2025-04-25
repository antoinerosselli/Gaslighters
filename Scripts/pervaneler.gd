extends MeshInstance3D

var axis = Vector3(0, 1, 0) # Or Vector3.RIGHT
@export var rotation_amount = 0.03

func _process(_delta):
	transform.basis = Basis(axis, rotation_amount) * transform.basis
