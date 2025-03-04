extends Camera3D

func _physics_process(_delta):
	if current == true and Input.is_action_just_pressed("close"):
		var player = Tools.get_player()
		var camera_player = player.get_node("Camera3D")
		current = false
		var player_icon = player.get_node("CanvasLayer/Control/Icon")
		var player_use = player.get_node("CanvasLayer/Control/Label")
		Tools.change_lesinputs("player")
		player_icon.visible = true
		player_use.visible = true
		camera_player.current = true
		player.paused = false
