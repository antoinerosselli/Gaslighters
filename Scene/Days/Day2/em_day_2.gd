extends Node

@export_category("Depots Manager")
@export var DANGER_LEVEL: int
@onready var depots = []
@onready var animation_player = $"../AnimationPlayer"

@export_category("Events Manager")

@export_category("Radio Manager")
#gouv
var gouv_color = Color(0.117647, 0.564706, 1, 1)
var gouv_time = 0
#belle
var belle_color = Color(1, 0.0784314, 0.576471, 1)
var belle_time = 0
#Fanatic
var Fanatic_color = Color(0.545098, 0, 0, 1)
var Fanatic_time = 0
var played_messages = {}  # Dictionnaire pour stocker les messages déjà joués
var ones: bool = false

#TIMER
var time_elapsed = 0

func _ready():
	depots = get_tree().get_nodes_in_group("depot")

func _process(_delta):
	if animation_player.is_playing():
		if UniqueTrait.elec == true and animation_player.get_current_animation() == "REDEVENT":
			Tools.get_player().detect()
	if ones == false:
		if Radio.getValue() > 88 and Radio.getValue() < 98 :
			play_radio_message("res://voice/day2/special_voice/voice_changer.mp3", "Rczij ocz gdvzo wgzzo, ocz dmdi ned vaapomn, ozij tp rdffvmdsj oz nvodmo ja ocz gziny wzgjr", 5, Fanatic_color, "enigm", 10)
			Tools.start_the_day()
	if ones == false and Tools.get_color_fd() == "red":
		print("start the day")
		activate_depots()
		ones = true
	if time_elapsed == 220 and UniqueTrait.elec == false:
		Tools.timer_event_action(true)
		time_elapsed += 1

func activate_depots():
	var available_depots = depots.filter(func(depot): return !depot.activation) 
	if available_depots.is_empty():
		return 
	available_depots.shuffle() 
	for i in range(min(DANGER_LEVEL, available_depots.size())):
		available_depots[i].activation = true

func _on_timer_timeout():
	time_elapsed += 1
	print(time_elapsed)
	check_event_conditions()
	check_radio_conditions()

func check_event_conditions():
	if Tools.get_color_fd() == "red":
		Tools.expe_status(true)
		Tools.timer_event_action(false)
	if time_elapsed == 225:
		var suit = get_tree().get_first_node_in_group("suitcase")
		suit.visible = true
		Tools.door_letter()
		if UniqueTrait.elec == true:
			Tools.timer_event_action(false)
	if time_elapsed == 233:
		print("REDEVENT")
		animation_player.play("REDEVENT")
	if time_elapsed == 500:
		Tools.eotd()

#RADIO
func play_radio_message(file_path, text, duration, color, sender, what_cd):
	if text in played_messages:  
		return  
	
	radio_event_adv(file_path, text, duration, color, sender, what_cd) 
	played_messages[text] = true  

func radio_event_adv(sound, text, time_text, color_ok, what_fm, what_cd):
	Tools.set_radio_sound(1,load(sound))
	if what_cd == 0:
		Tools.radio_text(text,time_text,color_ok)
	elif what_cd != 0:
		Tools.radio_text(text, what_cd - 1, color_ok)
	Tools.add_journal(text, color_ok)
	Tools.unlock_fm(what_fm)
	if what_fm == "gouv":
		if what_cd != 0:
			gouv_time = time_elapsed + what_cd
	elif what_fm == "belle":
		if what_cd != 0:
			belle_time = time_elapsed + what_cd
	elif what_fm == "fanatic":
		if what_cd != 0:
			Fanatic_time = time_elapsed + what_cd
	elif what_fm == "enigm":
		pass

func check_radio_conditions():
	var radio_value = Radio.getFrequency()
	
	#gouv radio ==>
	if time_elapsed >= 10 and time_elapsed <= 40:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The mist has intensified overnight.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "For your safety, avoid opening any windows or doors.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "A curfew is now in effect. Movement is strictly prohibited without prior authorization", 5, gouv_color, "gouv", 0)
	if time_elapsed >= 60 and time_elapsed <= 100:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Evacuation teams are continuing their mission.", 5, gouv_color,"gouv", 0)
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Residents of the Old Miners’ Quarter will be secured today.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Prepare your personal belongings and remain close to your radio.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 140 and time_elapsed <= 180:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message ,", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Some of them may have escaped.", 5, gouv_color,"gouv", 0)
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", " If you have any information regarding their possible whereabouts, please contact the appropriate authorities.", 5, gouv_color, "gouv", 0)
	if time_elapsed >= 200 and time_elapsed <= 240:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Our rationing truck has encountered a technical issue.", 5, gouv_color,"gouv", 0)
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Deliveries will be suspended in certain districts over the coming days.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Rest assured that the water services teams are working daily to ensure no one is left without access to water.", 5, gouv_color,"gouv", 0)

	#belle radio ==>
	if time_elapsed >= 10 and time_elapsed <= 40:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The mist has intensified overnight.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "For your safety, avoid opening any windows or doors.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "A curfew is now in effect. Movement is strictly prohibited without prior authorization", 5, gouv_color, "gouv", 0)
	if time_elapsed >= 60 and time_elapsed <= 100:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Evacuation teams are continuing their mission.", 5, gouv_color,"gouv", 0)
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Residents of the Old Miners’ Quarter will be secured today.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Prepare your personal belongings and remain close to your radio.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 140 and time_elapsed <= 180:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message ,", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Some of them may have escaped.", 5, gouv_color,"gouv", 0)
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", " If you have any information regarding their possible whereabouts, please contact the appropriate authorities.", 5, gouv_color, "gouv", 0)
	if time_elapsed >= 200 and time_elapsed <= 240:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Our rationing truck has encountered a technical issue.", 5, gouv_color,"gouv", 0)
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Deliveries will be suspended in certain districts over the coming days.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Rest assured that the water services teams are working daily to ensure no one is left without access to water.", 5, gouv_color,"gouv", 0)
