extends Node
@onready var animation_player = $"../AnimationPlayer"
var time_elapsed = 0

func _ready():
	animation_player.play("rencontredu3emetype")

func _on_timer_timeout():
	time_elapsed += 1
	print(time_elapsed)
	check_event_conditions()

func talk_audio(odio, text_color):
	if text_color == Tools.color_me:
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
		talk("res://voice/day3_5/dontmove.ogg", "Don’t move." ,Tools.color_enigm , 6)
	if time_elapsed == 39 : 
		talk("res://voice/day3_5/weknowwhatyoudid.ogg", "We know what you did. You let them rot down there." ,Tools.color_enigm , 6)
	if time_elapsed == 46 : 
		talk("res://voice/day3_5/forgotten.ogg", "You think that gets forgotten? You think you can buy that off ?" ,Tools.color_enigm , 6)
	if time_elapsed == 53 : 
		talk("res://voice/day3_5/pay.ogg", "You’re gonna pay." ,Tools.color_enigm , 6)
	if time_elapsed == 60 : 
		talk("res://Music&Sound/sound/heavy_swallowwav-14682.mp3", "Wait…" ,Tools.color_me , 6)
	if time_elapsed == 67 : 
		talk("res://voice/day3_5/youneedtolisten.ogg", "No. You don’t need to talk. You need to listen." ,Tools.color_enigm , 6)
	if time_elapsed == 74 : 
		talk("res://voice/day3_5/debt.ogg", "Inside is your debt." ,Tools.color_enigm , 6)
	if time_elapsed == 81 : 
		talk("res://voice/day3_5/maybesleepagain.ogg", "You’re gonna do what I say. And maybe… maybe you’ll sleep again." ,Tools.color_enigm , 6)
	if time_elapsed == 88 : 
		talk("res://voice/day3_5/doitorfindyou.ogg", "Do it. Or I’ll find you." ,Tools.color_enigm , 6)
	if time_elapsed == 95 : 
		talk("res://voice/day3_5/everytime.ogg", "Every time. As long as you breathe." ,Tools.color_enigm , 6)
