extends Node

func _process(_delta):
	if Input.is_action_pressed("freecam"):
		var cam = load("res://Prefab/freecam.tscn") as PackedScene
		var tmpcam = cam.instantiate()
		add_child(tmpcam)
