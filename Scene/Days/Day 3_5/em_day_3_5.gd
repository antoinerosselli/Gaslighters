extends Node
@onready var animation_player = $"../AnimationPlayer"
var time_elapsed = 0

var me_color = Color(1, 0.54902, 0, 1)
var Suit_color = Color(1, 0.980392, 0.941176, 1)

func _ready():
	animation_player.play("rencontredu3emetype")

func _on_timer_timeout():
	time_elapsed += 1
	print(time_elapsed)
	check_event_conditions()

func talk_audio(odio, text_color):
	if text_color == me_color:
		return
	var bouche = get_tree().get_first_node_in_group("talkers")
	bouche.set_stream(load(odio) as AudioStream)
	bouche.play()

	
func talk(odio, text,color, time):
	talk_audio(odio,color)
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	if time_elapsed == 32 :
		talk("res://voice/day3_5/dontmove.ogg", "Don’t move." ,Suit_color , 6)
	if time_elapsed == 39 : 
		talk("res://voice/day3_5/weknowwhatyoudid.ogg", "We know what you did. You let them rot down there." ,Suit_color , 6)
	if time_elapsed == 46 : 
		talk("res://voice/day3_5/forgotten.ogg", "You think that gets forgotten? You think you can buy that off ?" ,Suit_color , 6)
	if time_elapsed == 53 : 
		talk("res://voice/day3_5/pay.ogg", "You’re gonna pay." ,Suit_color , 6)
	if time_elapsed == 60 : 
		talk("res://Music&Sound/sound/heavy_swallowwav-14682.mp3", "Wait…" ,me_color , 6)
	if time_elapsed == 67 : 
		talk("res://voice/day3_5/youneedtolisten.ogg", "No. You don’t need to talk. You need to listen." ,Suit_color , 6)
	if time_elapsed == 74 : 
		talk("res://voice/day3_5/debt.ogg", "Inside is your debt." ,Suit_color , 6)
	if time_elapsed == 81 : 
		talk("res://voice/day3_5/maybesleepagain.ogg", "You’re gonna do what I say. And maybe… maybe you’ll sleep again." ,Suit_color , 6)
	if time_elapsed == 88 : 
		talk("res://voice/day3_5/doitorfindyou.ogg", "Do it. Or I’ll find you." ,Suit_color , 6)
	if time_elapsed == 95 : 
		talk("res://voice/day3_5/everytime.ogg", "Every time. As long as you breathe." ,Suit_color , 6)
