extends Node3D

var is_awake :bool= false

func _ready():
	get_tree().paused = false
	Data.set_level(30)
	Tools.set_elec(101)
	var player = get_tree().get_first_node_in_group("player")
	player.set_process(false)
	player.set_physics_process(false)
	Radio.setDisplay(2, "FM")
	Radio.setDisplay(1, "0.00")

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_awake == false:
		is_awake = true
		var player = get_tree().get_first_node_in_group("player")
		player.position = Vector3(-2.807, -0.408, 6.511) # Mettre une anim?
		#player.position = Vector3(-1.452, -0.152, 4.599)
		player.rotation = Vector3(0,0,0)
		player.set_process(true)
		player.set_physics_process(true)
		set_process(false)
