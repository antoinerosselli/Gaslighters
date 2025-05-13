extends Node

const ICON = preload("res://Sprite/icon.svg")

var val_elec:int = 60
var lum: int = 2

var color_me = Color(1, 0.54902, 0, 1)
var color_gov = Color(0.117647, 0.564706, 1, 1)
var color_galleries = Color(0.545098, 0, 0, 1)
var color_belle = Color(1, 0.0784314, 0.576471, 1)
var color_enigm = Color(0.686275, 0.933333, 0.933333, 1)
var color_ami = Color(0.580392, 0, 0.827451, 1)
var color_chaos = Color(0.67, 0.19, 0.54, 1)
var daltonian_mode = false

func toggle_daltonian_mode():
	daltonian_mode = !daltonian_mode

	if daltonian_mode:
		color_me = Color(1, 1, 0.4, 1)
		color_gov = Color(0.4, 1, 0.6, 1)
		color_galleries = Color(0.8, 0.4, 0, 1)
		color_belle = Color(1, 0.5, 0.7, 1)
		color_enigm = Color(0.4, 0.8, 1, 1)
		color_ami = Color(0.6, 0.6, 1, 1)
	else:
		color_me = Color(1, 0.54902, 0, 1)
		color_gov = Color(0.117647, 0.564706, 1, 1)
		color_galleries = Color(0.545098, 0, 0, 1)
		color_belle = Color(1, 0.0784314, 0.576471, 1)
		color_enigm = Color(0.686275, 0.933333, 0.933333, 1)
		color_ami = Color(0.580392, 0, 0.827451, 1)


func get_icon(item_name):
	match item_name:
		"test":
			return ICON as Texture2D
		_:
			print("param3 is not 3!")


func get_player():
	var player = get_tree().get_first_node_in_group("player")
	return player

func paused_game():
	get_tree().paused = !get_tree().paused
	if Tools.get_player() != null:
		if get_tree().paused == true:
			Tools.get_player().paused.visible = true
			Tools.get_player().logo_inter.visible = false
			Tools.get_player().icon.visible = false
		elif get_tree().paused == false:
			Tools.get_player().paused.visible = false
			Tools.get_player().logo_inter.visible = true
			Tools.get_player().icon.visible = true

func door_letter():
	var letter = get_tree().get_first_node_in_group("letter")
	var front_door = get_tree().get_first_node_in_group("frontdoor")
	Tools.sound_now(front_door, preload("res://Music&Sound/door-knocking-175163.mp3") as AudioStreamMP3)
	letter.get_child(2).play("slide_letter")

func go_to_expe():
	SteamControl.unlock_achievement("ACH_EXPE")
	var es:PackedScene
	if Data.get_level() == 1:
		es = preload("res://Prefab/expe.tscn") as PackedScene
	elif Data.get_level() == 2:
		es = preload("res://Prefab/expe_d2.tscn") as PackedScene
	elif Data.get_level() == 3:
		es = preload("res://Prefab/expe_d3.tscn") as PackedScene
	var es_tmp = es.instantiate()
	get_tree().get_first_node_in_group("canvas").visible = false
	add_child(es_tmp)	

func call_pause():
	if get_tree().get_first_node_in_group("pause") == null:
		var mp:PackedScene = preload("res://Prefab/ui/pause.tscn")
		var mp_tmp = mp.instantiate()
		add_child(mp_tmp)
	elif get_tree().get_first_node_in_group("pause") != null :
		var mp_tmp = get_tree().get_first_node_in_group("pause")
		mp_tmp.queue_free()

func call_options():
	var mp:PackedScene = preload("res://Prefab/options.tscn")
	var mp_tmp = mp.instantiate()
	var menu2d = get_tree().get_first_node_in_group("menu2d")
	if menu2d == null:
		var menu_pause = get_tree().get_first_node_in_group("pause")
		menu_pause.add_child(mp_tmp)
	else :
		menu2d.add_child(mp_tmp)

func get_color_fd():
	var lamp_door = get_tree().get_first_node_in_group("lamp_door")
	if lamp_door.spot_range != 0.00:
		if lamp_door.light_color == Color(1, 0, 0, 1):
			return "red"
		if lamp_door.light_color == Color(0, 0, 1, 1):
			return "blue"

func set_radio_sound(channel,sound:AudioStream):
	var radio_sound = get_tree().get_first_node_in_group("radio_sound")
	var audio_channel = radio_sound.get_child(channel - 1)
	audio_channel.set_stream(sound)
	audio_channel.play()

func radio_text(simple_text: String, time: float, color: Color) -> void:
	var player = Tools.get_player()
	var text_radio = player.get_node("CanvasLayer/Control/show_text_radio")
	var mod_text = '[wave amp=10.0 freq=3.0][font_size=21][center]' + simple_text + '[/center][/font_size][/wave]'
	text_radio.text = mod_text
	text_radio.modulate = color
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0.7)  
	style.content_margin_left = 20
	style.content_margin_right = 20
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	text_radio.add_theme_stylebox_override("normal", style)
	await get_tree().create_timer(time).timeout
	if text_radio != null:
		text_radio.text = ""
		style.bg_color = Color(0, 0, 0, 0)  
		text_radio.add_theme_stylebox_override("normal", style)

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
		if 	get_tree().get_first_node_in_group("govfm").visible == false : 
			Tools.new_info("new channel : Gov Fm")
		get_tree().get_first_node_in_group("govfm").visible = true
	if what_fm == "belle":
		if 	get_tree().get_first_node_in_group("bellefm").visible == false : 
			Tools.new_info("new channel : Belle Fm")
		get_tree().get_first_node_in_group("bellefm").visible = true
	if what_fm == "fanatic":
		if 	get_tree().get_first_node_in_group("fanaticfm").visible == false : 
			Tools.new_info("new channel : Galleries Fm")
		get_tree().get_first_node_in_group("fanaticfm").visible = true
	if what_fm == "enigm":
		if 	get_tree().get_first_node_in_group("enigmfm").visible == false : 
			Tools.new_info("new channel : ??? Fm")
		get_tree().get_first_node_in_group("enigmfm").visible = true

func spawn_conserve(i):
	get_tree().get_first_node_in_group("foods").update_conserves(i)
	
func get_elec():
	return val_elec
	
func set_elec(nval):
	if nval <= 0:
		nval = 0
		UniqueTrait.elec = false
		var light_elec = get_tree().get_first_node_in_group("courantup")
		Tools.sound_now(light_elec, load("res://Music&Sound/electric-155027.mp3") as AudioStream)
		if UniqueTrait.elec == false:
			light_elec.omni_range = 0
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
	audio_player.position = here.get_global_position()
	audio_player.autoplay = true
	audio_player.finished.connect(func(): audio_player.queue_free())
	here.get_parent().add_child(audio_player)

func start_transition(text,nscene):
	Tools.paused_game()
	var cl = get_tree().get_first_node_in_group("transi")
	cl.transition(text, nscene)

func eotd():
	if Data.get_level() == 4:
		var horn = get_tree().get_first_node_in_group("sound_end")
		var valise = get_tree().get_first_node_in_group("valise")
		valise.activate = true
		horn.play()
	else:
		var alarm =  get_tree().get_first_node_in_group("alarmepills")
		var pills = get_tree().get_first_node_in_group("pills")
		alarm.go_bip()
		pills.spawn()

func notespawn(note):
	var player = Tools.get_player()
	var canvas = get_tree().get_first_node_in_group("canvas")
	change_lesinputs("note")
	player.can_interact = false
	player.icon.visible = false
	var inst = note.instantiate()
	canvas.add_child(inst)
	canvas.move_child(inst,0)

func note_close(note, player):
	Tools.change_lesinputs("player")
	player.icon.visible = true
	player.can_interact = true
	note.queue_free()
	
func change_lesinputs(what_lesinputs):
	var text_input = get_tree().get_first_node_in_group("lesinputs")
	if what_lesinputs == "inventory":
		text_input.text = "[ TAB ] Close"
	if what_lesinputs == "player":
		text_input.text = "[ E ] Interact
[ Tab ] Info
[ Ctrl ] Crouch"
	if what_lesinputs == "frontdoor" or what_lesinputs == "note":
		text_input.text = "[ C ] Close"
	if what_lesinputs == "radio":
		text_input.text = "[ C ] Close
		[ Player Move ] Change FM"
	if what_lesinputs == "blank":
		text_input.text == ""
		
func start_the_day():
	var timerevent = get_tree().get_first_node_in_group("timerevent")
	timerevent.start()

func colis_departure():
	var TS = get_tree().get_first_node_in_group("truckspawn")
	TS.truck_spawn()

func expe_status(status):
	var expe_lum = get_tree().get_first_node_in_group("canexpe")
	var anim = get_tree().get_first_node_in_group("animexpe")
	Tools.sound_now(expe_lum,preload("res://Music&Sound/sound/expeopen.ogg") as AudioStreamOggVorbis )
	if status == true and expe_lum:
		anim.play("start_expe")
		expe_lum.set_color(Color(0, 1, 0, 1))
	elif status == false and anim:
		anim.play("end_expe")
		expe_lum.set_color(Color(1, 0, 0, 1))

func get_expe_status():
	var expe_lum = get_tree().get_first_node_in_group("canexpe")
	if expe_lum.get_color() == Color(0,1,0,1) :
		return true
	else:
		return false

func event_journal_ok(index, missed):
	var eventjournal = get_tree().get_first_node_in_group("eventjournal")
	if index < 0 or index >= eventjournal.get_child_count():
		return
	var entry = eventjournal.get_child(index)
	if missed and not entry.visible:
		entry.text = "[color=#ff0000][shake]!   M i s s e d   ![/shake][/color]"
	entry.visible = true
	var journal = Data.get_journal()
	if not journal.has(entry.text):
		Data.journal_text.append(entry.text)
		Data.save_data()


func timer_event_action(is_active):
	var timer_event = get_tree().get_first_node_in_group("timerevent")
	if is_active == false:
		timer_event.stop()
	elif is_active == true:
		timer_event.start()

func get_timer_action():
	var timer_event = get_tree().get_first_node_in_group("timerevent")
	return timer_event.is_stopped()

func radio_text_glitch(simple_text: String, time: float, color: Color) -> void:
	var player = Tools.get_player()
	var text_radio = player.get_node("CanvasLayer/Control/show_text_radio")
	if text_radio == null:
		return
	
	# Sauvegarde des paramètres visuels
	var original_theme = text_radio.theme
	var original_modulate = text_radio.modulate
	var original_theme_overrides = {}
	for names in text_radio.get_property_list():
		if names.name.begins_with("theme_override_"):
			original_theme_overrides[names.name] = text_radio.get(names.name)
	
	# Applique le fond noir semi-transparent
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0.7)
	style.content_margin_left = 20
	style.content_margin_right = 20
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	text_radio.add_theme_stylebox_override("normal", style)
	text_radio.bbcode_enabled = true
	text_radio.modulate = color
	
	# Glitch settings
	var alphabet := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?@#%&*"
	var glitch_speed := 0.05
	var glitch_cycles := 10
	
	# Génère le texte final avec BBCode
	var mod_text := "[wave amp=10.0 freq=3.0][font_size=21][center]" + simple_text + "[/center][/font_size][/wave]"
	
	# Effet glitch sur toute la phrase
	for i in range(glitch_cycles):
		var glitch_text := ""
		for c in simple_text:
			if c == " ":
				glitch_text += " "
			else:
				glitch_text += alphabet[randi() % alphabet.length()]
		var temp_bbcode := "[wave amp=10.0 freq=3.0][font_size=21][center]" + glitch_text + "[/center][/font_size][/wave]"
		text_radio.text = temp_bbcode
		await get_tree().create_timer(glitch_speed).timeout
	
	# Affiche le texte final après les glitchs
	text_radio.text = mod_text
	
	# Garde le texte pendant le temps voulu
	await get_tree().create_timer(time).timeout
	
	# Nettoyage
	text_radio.text = ""
	style.bg_color = Color(0, 0, 0, 0)
	text_radio.add_theme_stylebox_override("normal", style)
	text_radio.modulate = original_modulate
	text_radio.theme = original_theme
	for key in original_theme_overrides:
		text_radio.set(key, original_theme_overrides[key])

func new_info(ninfo):
	var nmess = get_tree().get_first_node_in_group("infochat")
	nmess.newmessage(ninfo)
