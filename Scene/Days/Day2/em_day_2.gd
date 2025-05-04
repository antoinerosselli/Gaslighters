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
var first_message: bool = false
var expe_dispo: bool = true

#TIMER
var time_elapsed = 0

func _ready():
	depots = get_tree().get_nodes_in_group("depot")

func _process(_delta):
	if animation_player.is_playing():
		if UniqueTrait.elec == true and animation_player.get_current_animation() == "REDEVENT":
			Tools.get_player().detect()
	if ones == false and first_message == false:
		if Radio.getValue() > 88 and Radio.getValue() < 98 :
			play_radio_message("res://voice/day2/special_voice/voice_changer.mp3", "Rczij ocz gdvzo wgzzo, ocz dmdi ned vaapomn, ozij tp rdffvmdsj oz nvodmo ja ocz gziny wzgjr", 5, Fanatic_color, "enigm", 10)
			Tools.event_journal_ok(0,false)
			Tools.start_the_day()
			first_message = true
	if ones == false and Tools.get_color_fd() == "red":
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
	check_event_conditions()
	check_radio_conditions()

func check_event_conditions():
	if Tools.get_color_fd() == "red" and expe_dispo == true:
		Tools.expe_status(true)
		Tools.timer_event_action(false)
		expe_dispo = false
	if time_elapsed >= 223 and UniqueTrait.elec == false:
		activate_depots()
		Tools.new_info("they are coming")
		SteamControl.unlock_achievement("ACH_SUIT")
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
		Data.set_radio("G")
		if what_cd != 0:
			gouv_time = time_elapsed + what_cd
	elif what_fm == "belle":
		Data.set_radio("B")
		if what_cd != 0:
			belle_time = time_elapsed + what_cd
	elif what_fm == "fanatic":
		Data.set_radio("M")
		if what_cd != 0:
			Fanatic_time = time_elapsed + what_cd
	elif what_fm == "enigm":
		pass

func check_radio_conditions():
	var radio_value:float = Radio.getValue()
	
	##MISSED 
	if time_elapsed == 271:
		Tools.event_journal_ok(4,true)
	if time_elapsed == 181:
		Tools.event_journal_ok(3,true)
	if time_elapsed == 271:#done
		Tools.event_journal_ok(2,true)
	if time_elapsed == 256:
		Tools.event_journal_ok(1,true)

	#gouv radio ==>
	if time_elapsed >= 10 and time_elapsed <= 60:
		animation_player.play("REDEVENT")
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The mist has intensified overnight.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "For your safety, avoid opening any windows or doors.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "A curfew is now in effect. Movement is strictly prohibited without prior authorization", 5, gouv_color, "gouv", 0)
	if time_elapsed >= 80 and time_elapsed <= 125:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Evacuation teams are continuing their mission.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Residents of the Old Miners’ Quarter will be secured today.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Prepare your personal belongings and remain close to your radio.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 145 and time_elapsed <= 190:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message ,", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "A group of individuals was intercepted in the tunnels of the old mines.", 5, gouv_color,"gouv", 6)
			Tools.event_journal_ok(2,false)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Some of them may have escaped.", 5, gouv_color,"gouv", 6)
			Tools.event_journal_ok(2,false)
		if radio_value > 54 and radio_value < 64 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", " If you have any information regarding their possible whereabouts, please contact the appropriate authorities.", 5, gouv_color, "gouv", 6)
	if time_elapsed >= 210 and time_elapsed <= 255:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Our rationing truck has encountered a technical issue.", 5, gouv_color,"gouv", 6)
			Tools.event_journal_ok(1,false)
		if radio_value > 54 and radio_value < 64 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Deliveries will be suspended in certain districts over the coming days.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Rest assured that the water services teams are working daily to ensure no one is left without access to water.", 5, gouv_color,"gouv", 0)

	#belle radio ==>
	if time_elapsed >= 25 and time_elapsed <= 75:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Good evening everyone, this is Belle.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The mist is still here.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "It’s getting thicker… It feels heavier today. Maybe you feel it too, wherever you are.", 5, belle_color,"belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The government has announced a full curfew.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", " I’m speaking to you from my studio, with the doors shut, just like you, I imagine.", 5, belle_color, "belle", 0)
	if time_elapsed >= 115 and time_elapsed <= 170:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Good evening everyone, this is Belle ,", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "One thing is certain: the ration trucks haven’t reached several districts.", 5, belle_color,"belle", 6)
			Tools.event_journal_ok(1,false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "I’m still waiting too. If you’re in the same situation, let me know.", 5, belle_color, "belle", 6)
			Tools.event_journal_ok(1,false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "We have to stay in touch.", 5, belle_color,"belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Hold on. I’m staying with you.", 5, belle_color,"belle", 0)
	if time_elapsed >= 180 and time_elapsed <= 210:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Good evening everyone, this is Belle,", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Some of you have written to tell me they still haven’t seen the evacuation teams.", 5, belle_color,"belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "A listener from the Old Miners’ Quarter told me her street remains silent.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "She’s waiting, her bags are packed… but nothing.", 5, belle_color, "belle", 0)
	if time_elapsed >= 220 and time_elapsed <= 270:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Good evening everyone, this is Belle .", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "They say some of the suspicious individuals have slipped past the authorities.", 5, belle_color,"belle", 6)
			Tools.event_journal_ok(2,false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "But who are they ? And what were they doing underground ?", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "First the church, and now they’re found in the galleries…", 5, belle_color,"belle", 6)
			Tools.event_journal_ok(4,false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Have the religious been waiting for this moment to regain their ground ?", 5, belle_color,"belle", 6)
			Tools.event_journal_ok(4,false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Why choose now to return, after decades of silence and oppression ?", 5, belle_color,"belle", 0)

	#Galleries radio ==>
	if time_elapsed >= 50 and time_elapsed <= 100:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "My friends,", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "They say a group was intercepted in the old tunnels.", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "But these men… they are not survivors.", 5, Fanatic_color,"fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "They are revenants..", 5, Fanatic_color, "fanatic", 6)
			Tools.event_journal_ok(4,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Figures from a past we thought extinguished. Black robes. Ancient prayers.", 5, Fanatic_color, "fanatic", 0)
			Tools.event_journal_ok(4,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "They are the ones who once vowed to bring ruin to the miners, long ago.", 5, Fanatic_color, "fanatic", 0)
			Tools.event_journal_ok(3,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "And now, they reappear — conveniently — deep within our earth.", 5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 135 and time_elapsed <= 180:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "My friends ,", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Some say a few of them escaped. I tell you this: it was no accident.", 5, Fanatic_color,"fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The government let them slip through. Why ? To spread confusion ?", 5, Fanatic_color, "fanatic", 6)
			Tools.event_journal_ok(2,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "To erase the last fragments of our memory ?", 5, Fanatic_color,"fanatic", 6)
			Tools.event_journal_ok(3,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "They are the same ones who killed the miners' representative — I am certain of it.", 5, Fanatic_color,"fanatic", 0)
			Tools.event_journal_ok(3,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "They hide. They wait.", 5, Fanatic_color,"fanatic", 0)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "But so do we. We too know how to wait.", 5, Fanatic_color,"fanatic", 0)
	if time_elapsed >= 200 and time_elapsed <= 255:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "My friends .", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is not the end.", 5, Fanatic_color,"fanatic", 6)		
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", " It is an old war starting again.", 5, Fanatic_color,"fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Prepare yourselves.", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "We will descend deeper than ever before.", 5, Fanatic_color, "fanatic", 0)	
