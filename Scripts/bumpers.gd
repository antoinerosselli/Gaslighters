extends Control

func _on_timer_timeout():
	get_tree().change_scene_to_packed(load("res://Scene/menu3D.tscn") as PackedScene)
