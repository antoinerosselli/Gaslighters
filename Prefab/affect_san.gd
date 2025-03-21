extends Area3D

func _on_body_entered(body):
	if body.name == "player":
		body.sanity -= 10
