extends Control

func _on_video_stream_player_finished():
	get_tree().change_scene_to_packed(load("res://Scene/menu3D.tscn") as PackedScene)
