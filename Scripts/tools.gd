extends Node

const ICON = preload("res://Sprite/icon.svg")

var val_elec:int = 90

func get_icon(item_name):
	match item_name:
		"test":
			return ICON as Texture2D
		_:
			print("param3 is not 3!")

func valid_quest(quest_id):
	match quest_id :
		1:
			print("valid")
		_:
			print("rien")

func get_player():
	var player = get_tree().get_first_node_in_group("player")
	return player

func call_pause():
	if get_tree().get_first_node_in_group("pause") == null:
		var mp:PackedScene = preload("res://Prefab/ui/pause.tscn")
		var mp_tmp = mp.instantiate()
		add_child(mp_tmp)
		print("pause !!")
	elif get_tree().get_first_node_in_group("pause") != null :
		var mp_tmp = get_tree().get_first_node_in_group("pause")
		mp_tmp.queue_free()

func get_color_fd():
	var lamp_door = get_tree().get_first_node_in_group("lamp_door")
	if lamp_door.spot_range != 0.00:
		print(lamp_door.light_color)
		if lamp_door.light_color == Color(1, 0, 0, 1):
			return "red"
		if lamp_door.light_color == Color(0, 0, 1, 1):
			return "blue"

func set_radio_sound(channel,sound):
	var radio_sound = get_tree().get_first_node_in_group("radio_sound")
	var audio_channel = radio_sound.get_child(channel - 1)
	print(audio_channel.name)
	audio_channel.set_stream(sound)
	audio_channel.play()

func radio_text(simple_text, time, color):
	var player = Tools.get_player()
	var text_radio = player.get_node("CanvasLayer/Control/show_text_radio")
	var mod_text = '[wave amp=10.0 freq=3.0][font_size=21][center]' + simple_text + '[/center][/font_size][/wave]'
	text_radio.text = mod_text
	text_radio.modulate = color
	var timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = true
	timer.timeout.connect(func(): text_radio.text = "")
	add_child(timer)
	timer.start()
	
func add_journal(text, ncolor):
	var journal_inside = get_tree().get_first_node_in_group("journal_inside")
	if journal_inside and journal_inside is RichTextLabel:
		journal_inside.bbcode_enabled = true
		var color_string = ncolor.to_html(false)  # Convertit la couleur en code hexadécimal sans alpha
		var formatted_text = "[color=#" + color_string + "]" + str(text) + "[/color]\n"
		journal_inside.text += formatted_text
	else:
		print("Le nœud 'journal_inside' est introuvable ou n'est pas un RichTextLabel.")
		
func start_sound(path):
	var event_sound = get_tree().get_first_node_in_group("event_sound")
	event_sound.set_stream(load(path) as AudioStreamMP3)
	event_sound.play()
	
func unlock_fm(what_fm):
	if what_fm == "gouv":
		get_tree().get_first_node_in_group("govfm").visible = true
	if what_fm == "belle":
		get_tree().get_first_node_in_group("bellefm").visible = true
	if what_fm == "fanatic":
		get_tree().get_first_node_in_group("fanaticfm").visible = true

func spawn_conserve(i):
	get_tree().get_first_node_in_group("spawner").spawn_conserve(i)
	
func get_elec():
	return val_elec
	
func set_elec(nval):
	val_elec = nval

func San_modif(santexture):
	var sanmodif = get_tree().get_first_node_in_group("sanmodif")
	sanmodif.set_texture(load(santexture) as Texture2D)


func sound_now(here: Node3D, what_sound: AudioStream):
	if not here or not what_sound:
		print("Erreur: Paramètres invalides (here ou what_sound manquant)")
		return
		
	var audio_player = AudioStreamPlayer3D.new()
	audio_player.stream = what_sound
	audio_player.global_position = here.get_global_position()
	audio_player.autoplay = true 
	audio_player.finished.connect(func(): audio_player.queue_free())

	here.get_parent().add_child(audio_player)


func start_transition(text,nscene):
	var cl = get_tree().get_first_node_in_group("transi")
	cl.transition(text, nscene)

#demo	
func eotd():
	var alarm =  get_tree().get_first_node_in_group("alarmepills")
	var pills = get_tree().get_first_node_in_group("pills")
	alarm.go_bip()
	pills.spawn()

func notespawn(note):
	var player = Tools.get_player()
	player.paused = true
	player.get_node("CanvasLayer/Control/").visible = false
	var inst = note.instantiate()
	player.add_child(inst)
	player.move_child(inst,0)

func change_lesinputs(what_lesinputs):
	var text_input = get_tree().get_first_node_in_group("lesinputs")
	if what_lesinputs == "player":
		text_input.text = "[ E ] Interact
[ Tab ] Journal
[ Ctrl ] Crouch"
	if what_lesinputs == "frontdoor":
		text_input.text = "[ C ] Close"
	if what_lesinputs == "radio":
		text_input.text = "[ C ] Close
		[ Move ] Change FM"

		
func start_the_day():
	var timerradio = get_tree().get_first_node_in_group("timerradio")
	var timerevent = get_tree().get_first_node_in_group("timerevent")
	timerradio.start()
	timerevent.start()
