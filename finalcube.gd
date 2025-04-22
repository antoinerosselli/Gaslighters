extends Node3D

var rotation_speed := Vector3(1.0, 1.0, 1.0) # vitesses de rotation pour chaque axe
var direction := Vector3(1, 1, 1) # direction actuelle pour chaque axe
var change_interval := 2.0 # temps en secondes entre chaque changement possible
var time_since_change := 0.0

func _process(delta: float) -> void:
	# Rotation du cube
	rotate_x(deg_to_rad(rotation_speed.x * direction.x * delta * 60))
	rotate_y(deg_to_rad(rotation_speed.y * direction.y * delta * 60))
	rotate_z(deg_to_rad(rotation_speed.z * direction.z * delta * 60))

	# Gestion du changement de direction
	time_since_change += delta
	if time_since_change >= change_interval:
		time_since_change = 0.0
		_randomize_direction()

func _randomize_direction() -> void:
	# Pour chaque axe, on a une chance de changer de direction
	for i in 3:
		if randf() < 0.5:
			direction[i] *= -1

	
