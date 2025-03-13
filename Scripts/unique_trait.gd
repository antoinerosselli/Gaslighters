extends Node

var elec:bool = true

func unique(object_name):
	match object_name:
		"codesr":
			var sdoor = get_tree().get_first_node_in_group("secretdoor")
			sdoor.get_node("AnimationPlayer").play("open")
		"front_door":
			var front_door = get_tree().get_first_node_in_group("frontdoor")
			var door_camera = front_door.get_node("Camera3D")
			var player = Tools.get_player()
			var player_camera = player.get_node("Camera3D")
			var player_icon = player.get_node("CanvasLayer/Control/Icon")
			var player_use = player.get_node("CanvasLayer/Control/Label")
			player_icon.visible = false
			player_use.visible = false
			player.paused = true
			player_camera.current = false
			Tools.change_lesinputs("frontdoor")
			door_camera.current = true
		"blue_lamp":
			Tools.sound_now(Tools.get_player(), load("res://Music&Sound/sound/interrupteur_sound.mp3") as AudioStream)
			var lamp_door = get_tree().get_first_node_in_group("lamp_door")
			lamp_door.light_color = Color(0, 0, 1, 1)
		"red_lamp":
			Tools.sound_now(Tools.get_player(), load("res://Music&Sound/sound/interrupteur_sound.mp3") as AudioStream)
			var lamp_door = get_tree().get_first_node_in_group("lamp_door")
			lamp_door.light_color = Color(1, 0, 0, 1)
		"neutral_lamp":
			Tools.sound_now(Tools.get_player(), load("res://Music&Sound/sound/interrupteur_sound.mp3") as AudioStream)
			var lamp_door = get_tree().get_first_node_in_group("lamp_door")
			lamp_door.light_color = Color(0, 0, 0, 0)
		"sancheck":
			if elec == true :
				var player = Tools.get_player()
				Tools.sound_now(player,load("res://Music&Sound/sound/sancheck_sound.mp3") as AudioStream)
				if player.sanity >= 70: 
					Tools.San_modif("res://Sprite/sancheck_ok.png")
				elif player.sanity <= 70 and player.sanity >= 30:
					Tools.San_modif("res://Sprite/sancheck_mid.png")
				elif player.sanity < 30:
					Tools.San_modif("res://Sprite/sancheck_bad.png")
		"courant":
			var light_elec = get_tree().get_first_node_in_group("courantup")
			Tools.sound_now(light_elec, load("res://Music&Sound/electric-155027.mp3") as AudioStream)
			elec = !elec
			if elec == true:
				light_elec.omni_range = 3
			if elec == false:
				light_elec.omni_range = 0
		"radio":
			var radioObj = get_tree().get_first_node_in_group("radio")
			var radio_camera = radioObj
			var player = Tools.get_player()
			Tools.change_lesinputs("radio")
			var player_camera = player.get_node("Camera3D")
			var player_icon = player.get_node("CanvasLayer/Control/Icon")
			var player_use = player.get_node("CanvasLayer/Control/Label")
			player_icon.visible = false
			player_use.visible = false
			player.use_radio = true
			player.paused = true
			player_camera.current = false
			radio_camera.current = true
		"conserve":
			get_tree().get_first_node_in_group("foods").add_conserve()
			print("TAKE FOOD")
		"pills":
			Tools.start_transition("2 YEARS AGO", load("res://Scene/Days/Day 1.5/scene_day_1_5.tscn") as PackedScene)
		"pen":
			Tools.start_transition("5 MONTHS AGO", load("res://Scene/Days/Day 2.5/scene_day_2_5.tscn") as PackedScene)
		"phone":
			print("phone")
			Tools.start_transition("1 YEARS AGO", load("res://Scene/Days/Day 3.5/scene_day_3_5.tscn") as PackedScene)
		"screencamera":
			print("use screen")
			var screencam = get_tree().get_first_node_in_group("screencam")
			screencam.allume = !screencam.allume
			print(screencam.allume)
			if screencam.allume == true:
				screencam.yescamcam()
			elif screencam.allume == false:
				screencam.nocamcam()
		"ptichpitch":
			print("i take the ptich")
			var player = Tools.get_player()
			player.on_hand()
			var model = get_tree().get_first_node_in_group("ptichptich_depose")
			model.visible = !model.visible
