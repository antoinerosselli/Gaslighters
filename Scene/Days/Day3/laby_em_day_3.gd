extends Node

@export_category("Depots Manager")
@export var DANGER_LEVEL: int
@onready var depots = []
@onready var animation_player = $"../AnimationPlayer"

@export_category("Events Manager")

@export_category("Radio Manager")
#gouv
var gouv_time_1 = 0
var gouv_time_3 = 0
#belle
var belle_time_1 = 0
var belle_time_3 = 0
#Fanatic
var miners_time_1 = 0
var miners_time_3 = 0
var ones: bool = false

#TIMER
var time_elapsed = 0
var timeLogic :int= 0

#Laby ress
static var radio_1_loop_gov :int= 0
static var radio_1_loop_belle :int= 0
static var radio_1_loop_miners :int= 0
static var radio_3_loop_gov :int= 0
static var radio_3_loop_belle :int= 0
static var radio_3_loop_miners :int= 0
var postercypher = null#get_tree().get_nodes_in_group("vigenereposter")
static var actualPoster = 3 #Full blur = 3, medium blur = 2, light blur = 1, full image = 0
var posterTexture2 = load("res://Extern/FONT/FMFMbluir2.png")
var posterTexture1 = load("res://Extern/FONT/FMFMbluir3.png")
var posterTexture = load("res://Extern/FONT/FMFMbluir.png")
var radioTrigger :bool= false

func _process(delta: float) -> void:
	if ones == false:
		if get_tree().get_first_node_in_group("player").is_processing():
			ones = true

func _on_timer_timeout() -> void:
	time_elapsed += 1
	print(time_elapsed)
	check_radio_conditions()
	

func exe_radio_msg(radio, fp, text, duration, color, sender, cooldown, loop_audio):
	apply_specific_radio_sound(radio, load(fp) as AudioStream, loop_audio)
	if cooldown == 0:
		Tools.radio_text(text,duration,color)
	elif cooldown != 0:
		Tools.radio_text(text, cooldown - 1, color)
	if Tools.get_player().is_interacting_with().get_child(0).name == radio.name:
		Tools.add_journal(text, color)
	
	if cooldown != 0:
		match sender:
			"gouv1":
				gouv_time_1 = time_elapsed + cooldown
			"gouv2":
				gouv_time_3 = time_elapsed + cooldown
			"belle1":
				belle_time_1 = time_elapsed + cooldown
			"belle3":
				belle_time_3 = time_elapsed + cooldown
			"miners1":
				miners_time_1 = time_elapsed + cooldown
			"miners3":
				miners_time_3 = time_elapsed + cooldown
			

func apply_specific_radio_sound(radio :Node3D, sound :AudioStream, loop :bool):
	var radio_sound = radio.find_child("AudioStreamPlayer3D", true, false)
	var audio_channel = radio_sound.get_child(0)
	audio_channel.set_stream(sound)
	#audio_channel.set_loop(loop)
	audio_channel.play()

func setPosterTexture(nb :int):
	if nb > 2 or nb < 0 or actualPoster <= nb:
		return
	
	actualPoster = nb 
	
	#for poster in postercypher:
		#match nb:
			#2: poster.set_texture("posterTexture2")
			#1: poster.set_texture("posterTexture1")
			#0: poster.set_texture("posterTexture")

func check_radio_conditions() -> void:
	var _fm = Radio.getFrequency()
	
	if ones == false: return
	
	var radioUno = get_tree().get_root().find_child("Radiooo2-1", true, false)
	var radioDos = get_tree().get_root().find_child("Radiooo2-3", true, false)
	var radioTres = get_tree().get_root().find_child("Radiooo2-4", true, false)
	var radioQuatro = get_tree().get_root().find_child("Radiooo2-5", true, false)
	var currRadio = null
	
	if Tools.get_player().is_interacting_with():
		currRadio = Tools.get_player().is_interacting_with().get_child(0)
	if currRadio:
		print("CurrRadio = "+currRadio.name)
	if Radio.getValue() == 50.13:
		timeLogic += 1
		if timeLogic >= 5:
			secrets_unfolded(radioDos)
	elif timeLogic < 100:
		timeLogic = 0
	
	if _fm == 1:
		# Radio 1
		if time_elapsed > gouv_time_1 and radio_1_loop_gov == 0 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "This is an official government message.", 5, Tools.color_gov, "gouv1", 6,false)
			radio_1_loop_gov+=1
		if time_elapsed > gouv_time_1 and radio_1_loop_gov == 1 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "The districts’ evacuation is still ongoing.", 5, Tools.color_gov, "gouv1", 6,false)
			radio_1_loop_gov+=1
		if time_elapsed > gouv_time_1 and radio_1_loop_gov == 2 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "Road Quarter will be cleared next. Local inhabitants, please ready yourself for our arrival.", 9, Tools.color_gov, "gouv1", 10,false)
			radio_1_loop_gov+=1
		if time_elapsed > gouv_time_1 and radio_1_loop_gov == 3 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "We thank you for your cooperation.", 5, Tools.color_gov, "gouv1", 6,false)
			Tools.event_journal_ok(0, false)
			radio_1_loop_gov=0
		
		# Radio 3
		if currRadio == radioDos:
			exe_radio_msg(radioDos, ".", "Do not believe the lies.", 5, Tools.color_gov, "gouv", 6,false)
			Tools.event_journal_ok(1, false)
			setPosterTexture(2)
		
	
		# Radio 4
		if time_elapsed > gouv_time_3 and radio_3_loop_gov == 0 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Citizens of Rock Valley,", 5, Tools.color_gov, "gouv3", 6,false)
			radio_3_loop_gov+=1
		if time_elapsed > gouv_time_3 and radio_3_loop_gov == 1 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "The government requests that you put aside your internal quarrels.", 5, Tools.color_gov, "gouv3", 6,false)
			radio_3_loop_gov+=1
		if time_elapsed > gouv_time_3 and radio_3_loop_gov == 2 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Public confrontations are endangering the rescue teams and the citizens altogether.", 6, Tools.color_gov, "gouv3", 7,false)
			radio_3_loop_gov+=1
		if time_elapsed > gouv_time_3 and radio_3_loop_gov == 3 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "The quarter currently being evacuated is:", 5, Tools.color_gov, "gouv3", 6,false)
			radio_3_loop_gov+=1
		if time_elapsed > gouv_time_3 and radio_3_loop_gov == 4 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "???", 5, Tools.color_gov, "gouv", 6,false) # Quartier random?
			radio_3_loop_gov+=1
		if time_elapsed > gouv_time_3 and radio_3_loop_gov == 5 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "We are here, citizens. Be ready.", 5, Tools.color_gov, "gouv", 6,false)
			radio_3_loop_gov+=1
		if time_elapsed > gouv_time_3 and radio_3_loop_gov <= 6 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Wake up.", 5, Tools.color_gov, "gouv", 6,false)
			radio_3_loop_gov=0
		
		# Radio 5
		if currRadio == radioQuatro:
			exe_radio_msg(radioQuatro, ".", "Wake up.", 3, Tools.color_chaos, "???", 3,false)
	
	if _fm == 2:
		# Radio 1
		if time_elapsed > belle_time_1 and radio_1_loop_belle == 0 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "I am currently in my apartment’s secret room.", 5, Tools.color_belle, "belle1", 6,false)
			radio_1_loop_belle+=1
		if time_elapsed > belle_time_1 and radio_1_loop_belle == 1 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "I can hear struggles outside. Fights have become frequent in my street.", 5, Tools.color_belle, "belle1", 6,false)
			radio_1_loop_belle+=1
		if time_elapsed > belle_time_1 and radio_1_loop_belle == 2 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "Who keeps brawling at such a time? We should be helping each other out.", 5, Tools.color_belle, "belle1", 6,false)
			radio_1_loop_belle+=1
		if time_elapsed > belle_time_1 and radio_1_loop_belle <= 3 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "I urge my audience to stay discreet and safe.", 5, Tools.color_belle, "belle1", 6,false)
			radio_1_loop_belle=0
		
		# Radio 3
		if currRadio == radioDos:
			exe_radio_msg(radioDos, ".", "Do not believe the lies.", 5, Tools.color_belle, "belle", 6,false)
			Tools.event_journal_ok(2, false)
	
		# Radio 4
		if time_elapsed > belle_time_3 and radio_3_loop_belle == 0  and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Someone tried to crochet my door again today. Thank god, they didn’t stay too long.", 7, Tools.color_belle, "belle3", 8,false)
			radio_3_loop_belle+=1
		if time_elapsed > belle_time_3 and radio_3_loop_belle == 1 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "I was supposed to be evacuated today, but the night is falling already.", 5, Tools.color_belle, "belle3", 6,false)
			radio_3_loop_belle+=1
		if time_elapsed > belle_time_3 and radio_3_loop_belle == 2 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "But I still have hope. We must have faith that some people are out here to help us. ", 7, Tools.color_belle, "belle3", 8,false)
			radio_3_loop_belle+=1
		if time_elapsed > belle_time_3 and radio_3_loop_belle == 3 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "My dear listeners. Keep hoping. Stay safe.", 5, Tools.color_belle, "belle3", 6,false)
			radio_3_loop_belle+=1
		if time_elapsed > belle_time_3 and radio_3_loop_belle <= 4 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Wake up.", 5, Tools.color_belle, "belle", 6,false)
			radio_3_loop_belle=0
		
		# Radio 5
		if currRadio == radioQuatro:
			exe_radio_msg(radioQuatro, ".", "Wake up.", 3, Tools.color_chaos, "???", 3,false)
	
	if _fm == 3: 
		# Radio 1
		if time_elapsed > miners_time_1 and radio_1_loop_miners == 0 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "My friends,", 5, Tools.color_galleries, "miners1", 6,false)
			radio_1_loop_miners+=1
		if time_elapsed > miners_time_1 and radio_1_loop_miners == 1 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "We are not to be bound by this tense climate.", 5, Tools.color_galleries, "miners1", 6,false)
			radio_1_loop_miners+=1
		if time_elapsed > miners_time_1 and radio_1_loop_miners == 2 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "It is our time to step into the light. We can save Rock valley.", 5, Tools.color_galleries, "miners1", 6,false)
			radio_1_loop_miners+=1
		if time_elapsed > miners_time_1 and radio_1_loop_miners <= 3 and currRadio == radioUno:
			exe_radio_msg(radioUno, ".", "By ourselves, not with words, but with acts.", 5, Tools.color_galleries, "miners1", 6,false)
			radio_1_loop_miners=0
		
		# Radio 3
		if currRadio == radioDos:
			exe_radio_msg(radioDos, ".", "Do not believe the lies.", 5, Tools.color_galleries, "miner", 6,false)
	
		# Radio 4
		if time_elapsed > miners_time_3 and radio_3_loop_miners == 0 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Citizens of Rock Valley,", 5, Tools.color_galleries, "miners3", 6,false)
			radio_3_loop_miners+=1
		if time_elapsed > miners_time_3 and radio_3_loop_miners == 1 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Neither god nor some government shall help us, therefore we are going to save ourselves.", 5, Tools.color_galleries, "miners3", 6,false)
			radio_3_loop_miners+=1
		if time_elapsed > miners_time_3 and radio_3_loop_miners == 2 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "We will not be blind to our people’s needs. It is time to put your faith in us.", 5, Tools.color_galleries, "miners3", 6,false)
			radio_3_loop_miners+=1
		if time_elapsed > miners_time_3 and radio_3_loop_miners <= 3 and currRadio == radioTres:
			exe_radio_msg(radioTres, ".", "Wake up.", 5, Tools.color_galleries, "miners3", 6,false)
			Tools.event_journal_ok(3, false)
			setPosterTexture(1)
			radio_3_loop_miners=0
		
		# Radio 5
		if currRadio == radioQuatro:
			exe_radio_msg(radioQuatro, ".", "Wake up.", 3, Tools.color_chaos, "???", 3,false)
	
	if _fm == 4:
		if currRadio == radioUno:
			apply_specific_radio_sound(radioUno, load("res://Music&Sound/Echexe2.mp3") as AudioStream, true)
		if currRadio == radioDos:
			apply_specific_radio_sound(radioDos, load("res://Music&Sound/Echexe2.mp3") as AudioStream, true)
		if currRadio == radioTres:
			apply_specific_radio_sound(radioTres, load("res://Music&Sound/Echexe2.mp3") as AudioStream, true)
		if currRadio == radioQuatro:
			apply_specific_radio_sound(radioQuatro, load("res://Music&Sound/Echexe2.mp3") as AudioStream, true)
		Tools.event_journal_ok(4, false)
		setPosterTexture(0)
		

func secrets_unfolded(radio :Node3D):
	SteamControl.unlock_achievement("ACH_MYSTERY_LABY3")
	timeLogic = 100
	exe_radio_msg(radio, ".", "We are not checkmated.",0,Tools.color_me, "Devs", 0, false)
