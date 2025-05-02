extends CollisionShape3D

@export var MarkerTarget :Marker3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.position = Vector3(MarkerTarget.position.x, player.position.y, MarkerTarget.position.z)
