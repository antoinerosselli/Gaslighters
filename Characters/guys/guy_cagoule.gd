extends Node3D

@onready var timer = $Timer

func _on_area_3d_body_entered(body):
	if body.name == "CharacterBody3D":
		timer.start()

func _on_area_3d_body_exited(body):
	if body.name == "CharacterBody3D":
		timer.stop()

func _on_timer_timeout():
	Tools.get_player().detect()
