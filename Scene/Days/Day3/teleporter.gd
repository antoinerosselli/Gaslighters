extends CollisionShape3D

@export var MarkerTarget :Marker3D
@export var tp_camera :Camera3D

func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.position = Vector3(MarkerTarget.position.x, MarkerTarget.position.y, MarkerTarget.position.z)
	player.rotation = Vector3(tp_camera.rotation.x, tp_camera.rotation.y, tp_camera.rotation.z)
	
