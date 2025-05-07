extends Node

var elec:bool = true

func unique(object_name):
	match object_name:
		"codesr":
			var sdoor = get_tree().get_first_node_in_group("secretdoor")
			sdoor.get_node("AnimationPlayer").play("open")
			var codesr = get_tree().get_first_node_in_group("codesr")
			codesr.activate = false
		"front_door":
			var front_door = get_tree().get_first_node_in_group("frontdoor")
			var door_camera = front_door.get_node("Camera3D")
			var player = Tools.get_player()
			var player_camera = player.get_node("Camera3D")
			var player_icon = player.get_node("CanvasLayer/Control/Icon")
			var player_use = player.get_node("CanvasLayer/Control/Label")
			player_icon.visible = false
			player_use.visible = false
			player_camera.current = false
			Tools.change_lesinputs("frontdoor")
			door_camera.current = true
		"blue_lamp":
			if Tools.get_timer_action() == true:
				Tools.timer_event_action(true)
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
		"broken_lamp":
			Tools.sound_now(Tools.get_player(), load("res://Music&Sound/sound/interrupteur_sound.mp3") as AudioStream)
			var lamp_door = get_tree().get_first_node_in_group("lamp_door")
			lamp_door.light_color = Color(randi_range(-1, 1), randi_range(-1,1), randi_range(-1,1), randi_range(-1,1))
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
				var screencam = get_tree().get_first_node_in_group("screencam")
				screencam.allume = false
				screencam.nocamcam()
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
			player_camera.current = false
			radio_camera.current = true
		"conserve":
			get_tree().get_first_node_in_group("foods").add_conserve()
		"pills":
			Tools.sound_now(Tools.get_player(),preload("res://Music&Sound/sound/heavy_swallowwav-14682.mp3") as AudioStreamMP3)
			if Data.get_level() == 1:
				SteamControl.unlock_achievement("ACH_END_DAY_1")
				Tools.start_transition("2 YEARS AGO", load("res://Scene/Days/Day 1.5/scene_day_1_5.tscn") as PackedScene)
			if Data.get_level() == 2:
				SteamControl.unlock_achievement("ACH_END_DAY_2")
				Tools.start_transition("2 MONTHS AGO", load("res://Scene/Days/Day 2.5/scene_day_2_5.tscn") as PackedScene)
			if Data.get_level() == 30:
				SteamControl.unlock_achievement("ACH_END_DAY_3")
				Tools.start_transition("2 WEEKS AGO", load("res://Scene/Days/Day 3_5/scene_day_3_5.tscn") as PackedScene)
		"fakepills":
			Tools.sound_now(Tools.get_player(),preload("res://Music&Sound/sound/heavy_swallowwav-14682.mp3") as AudioStreamMP3)
			var emds = get_tree().get_first_node_in_group("eventmanager")
			emds.eat_a_pills()
		"pen":
			Data.set_level(2)
			SteamControl.unlock_achievement("ACH_CONTRACT")
			Tools.start_transition("DAY 2", load("res://Scene/Days/Day2/scene_day_2.tscn") as PackedScene)
		"phone":
			Tools.start_transition("DAY 4", load("res://Scene/Days/Day4/scene_day_4.tscn") as PackedScene)
		"screencamera":
			var screencam = get_tree().get_first_node_in_group("screencam")
			Tools.sound_now(Tools.get_player(),preload("res://Music&Sound/sound/tvonoff.ogg") as AudioStreamOggVorbis)
			screencam.allume = !screencam.allume
			if UniqueTrait.elec == false:
				screencam.allume = false
			if screencam.allume == true:
				screencam.yescamcam()
			elif screencam.allume == false:
				screencam.nocamcam()
		"ptichpitch":
			var player = Tools.get_player()
			player.on_hand()
			var model = get_tree().get_first_node_in_group("ptichptich_depose")
			model.visible = !model.visible
		"suitexpe":
			var canexpe = get_tree().get_first_node_in_group("canexpe")
			var expe_color = canexpe.get_color()
			if expe_color == Color(0, 1, 0, 1):
				Tools.get_player().popup_sure.visible = true
		"fakedoorchamber":
			Tools.sound_now(Tools.get_player(),preload("res://Music&Sound/sound/door_sound.mp3") as AudioStreamMP3)
		"valise": 
			SteamControl.unlock_achievement("ACH_END_DAY_4")
			Tools.start_transition("", load("res://Scene/final_days/scene_final.tscn") as PackedScene)
		"valisevide":
			Tools.start_transition("DAY 4", load("res://Scene/Days/Day4/scene_day_4.tscn") as PackedScene)
		"doorexpe":
			Tools.get_player().popup_sure.visible = true
