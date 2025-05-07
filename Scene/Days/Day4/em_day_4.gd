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

var me_color = Color(1, 0.54902, 0, 1)
var other_color = Color(0.580392, 0, 0.827451, 1)

var played_messages = {}  # Dictionnaire pour stocker les messages déjà joués
var ones: bool = false

var BlueRadio: AnimatedSprite2D
var RedRadio: AnimatedSprite2D
var GreenRadio: AnimatedSprite2D
var SpecialRadio: AnimatedSprite2D

#part
var part1: bool = false
var part2: bool = false
var part3: bool = false
var otherpart: bool = false

@onready var animama = $"../AnimationPlayer"

#TIMER
var time_elapsed = 0

func _ready():
	BlueRadio = get_tree().get_first_node_in_group("blueradio")
	RedRadio = get_tree().get_first_node_in_group("redradio")
	GreenRadio = get_tree().get_first_node_in_group("greenradio")
	SpecialRadio = get_tree().get_first_node_in_group("specialradio")
	activate_depots()
	depots = get_tree().get_nodes_in_group("depot")
	activate_depots()

func _process(_delta):
	if  ones == false:
		RedRadio.visible = true
		if Radio.getValue() > 66 and Radio.getValue() < 76 :
			Tools.start_the_day()
			ones = true


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
	pass
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
	elif what_fm == "other":
		if what_cd != 0:
			Fanatic_time = time_elapsed + what_cd

func check_radio_conditions():
	var radio_value:float = Radio.getValue()

#gov
	if part1 == true and part2 == false:
		BlueRadio.visible = true
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The Road Quarter is currently being secured. Over 70% of Rock Valley’s residents are now safe.", 5, gouv_color, "gouv", 6)
			Tools.event_journal_ok(2,true)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Further clashes have occurred in the city, resulting in the disappearance of certain individuals during evacuation transports.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Some people are still missing. A special search team is currently handling the situation.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "…All of this—because of you.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "You really had to break your oath and put everyone at risk.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Was your own happiness not enough?", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Did you really think you could buy yourself redemption?", 5, gouv_color, "gouv", 0)
			BlueRadio.visible = false
			Tools.new_info("Next : the kitchen")
			animama.play("part2")
			part2 = true
			

#belle
	if part2 == true and part1 == true and part3 == false:
		GreenRadio.visible = true
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Hi, this is Belle.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Rock Valley has never felt more unsafe. I’m getting reports that evacuation transports have been attacked—leading to deaths and disappearances.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "It seems these were collateral damage from the ongoing conflict between former miners and surviving religious factions.", 5, belle_color,"belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "And you know you're not innocent in all this.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Or maybe you just preferred to look away.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "You locked yourself in a cage, thinking it would protect you. Then you threw away the key, hoping no one would drag you out.", 5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "You didn’t even notice. You’re stuck now in a state of numbness, unable to face the truth or escape to another one.", 5, belle_color, "belle", 0)
			GreenRadio.visible = false
			Tools.new_info("Then : the bathroom")
			animama.play("part3")
			part3 = true

#galleries
	if  part1 == false && part2 == false:
		RedRadio.visible = true
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "My friends,", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "The miners have informed me: the religious ones attacked an evacuation convoy. Innocents were caught in the crossfire.", 5, Fanatic_color, "fanatic", 6)
			Tools.event_journal_ok(0,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "These are terrible times. But we will not betray you. Rock Valley will emerge stronger.", 5, Fanatic_color,"fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "We fight for our independence. For our freedom.", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "So we don't become leashed dogs like you, “hero.”", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "You betrayed your brothers for a title, for peace…", 5, Fanatic_color, "fanatic", 6)
			Tools.event_journal_ok(1,false)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "To impress whom? To prove what?", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Now you’re trying to make up for it—But don’t think this one action redeems the fathers lost in the mines", 5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76 and time_elapsed > Fanatic_time:
			RedRadio.visible = false
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Nor the years your companions spent behind bars.", 5, Fanatic_color, "fanatic", 0)
			animama.play("part1")
			Tools.new_info("First : the secure room")
			part1 = true

#other
	if part1 == false and part2 == true and part3 == true and otherpart == true:
		SpecialRadio.visible = true
		if radio_value > 41 and radio_value < 43:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "You did your best.,", 5, other_color, "fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Was it enough?", 5, me_color, "fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "That’s not what matters.", 5, other_color,"fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "You stepped out of the cage you forged for yourself.", 5, other_color, "fanatic", 6)
			Tools.event_journal_ok(3,true)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "Look—you’re moving now.", 5, other_color, "fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "I know. But you're still afraid to call me", 5, me_color, "fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			Tools.radio_text_glitch("And I’m still afraid to call you.", 4.0, me_color)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "But this isn’t the end. Tomorrow is another day.", 5, other_color, "fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			Tools.radio_text_glitch("Maybe someday I’ll manage to do it.", 4.0, me_color)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "I hope so too.", 5, other_color, "fanatic", 6)
		if radio_value > 41 and radio_value < 43 and time_elapsed > Fanatic_time:
			SpecialRadio.visible = false
			Tools.event_journal_ok(5,true)
			Tools.radio_text_glitch("Let’s get out of here.", 4.0, me_color)
			Tools.eotd()
			otherpart = false
#event 
	if part1 == true and part2 == true and part3 == true : 
		SpecialRadio.visible = true 
		if radio_value > 37 and radio_value < 39 :
			Tools.new_info("The apartment collapses")
			animama.play("endgame")
			SpecialRadio.visible = false
			part1 = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "endgame":
		otherpart = true
