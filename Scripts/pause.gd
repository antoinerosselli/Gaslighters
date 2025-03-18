extends Button
@onready var control = $"../.."

func _on_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Tools.paused_game()
	control.queue_free()

func _on_quit_pressed():
	Tools.paused_game()
	control.queue_free()
	get_tree().change_scene_to_packed(load("res://Scene/menu3D.tscn") as PackedScene)
