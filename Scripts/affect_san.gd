extends Area3D

func _on_body_entered(body):
	if body.name == "CharacterBody3D":
		print(body.sanity)
		body.sanity -= 10
