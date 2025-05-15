extends Node

var time_elapsed = 0
var tmp_te = 5
var event_adv = 0
@onready var phone = $"../phone"
@onready var animation_player = $"../AnimationPlayer"

var time_between = 0
var i = 0

func _ready():
	animation_player.play("phonephase")
	phone.activate = false

func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()

func talk_audio(odio, text_color):
	if text_color == Tools.color_me:
		return
	var bouche = get_tree().get_first_node_in_group("phonesound")
	bouche.set_stream(load(odio) as AudioStream)
	bouche.play()
	
func talk(odio, text,color, time):
	talk_audio(odio,color)
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	if time_elapsed == 1 :
		talk_audio("res://Music&Sound/sound/phoneexte.ogg",Tools.color_galleries)
	if time_elapsed == 2 + 5 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "It’s me.",Tools.color_me , 6)
	if time_elapsed == 2 + 11 :
		talk("res://voice/day2_5/Iknewyoucall.ogg", "I knew you’d call.",Tools.color_galleries , 6)
	if time_elapsed == 2 + 18 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Don’t say anything. Not here. Not on this line.",Tools.color_me , 6)
	if time_elapsed == 2 + 25 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "I’m sorry.",Tools.color_me , 6)
	if time_elapsed == 2 + 32 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "For everything. For the silence. For the trial. For the years.",Tools.color_me , 6)
	if time_elapsed == 2 + 39 :
		talk("res://voice/day2_5/idontneedyourapo.ogg", "I don’t need your apologies.",Tools.color_galleries , 6)
	if time_elapsed == 2 + 46 :
		talk("res://voice/day2_5/whatdoyouwant.ogg", "What do you want?",Tools.color_galleries , 6)
	if time_elapsed == 2 + 53 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "I want you to come back.",Tools.color_me , 6)
	if time_elapsed == 2 + 60 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Not for me. For them.",Tools.color_me , 6)
	if time_elapsed == 2 + 67 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "For the ones who used to listen.",Tools.color_me , 6)
	if time_elapsed == 2 + 74 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Your voice... it gave them air.",Tools.color_me , 6)
	if time_elapsed == 2 + 81 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "You need to turn your radio back on.",Tools.color_me , 6)
	if time_elapsed == 2 + 88 :
		talk("res://voice/day2_5/andsaywhat.ogg", "And say what ?", Tools.color_galleries, 6)
	if time_elapsed == 2 + 95 :
		talk("res://voice/day2_5/spillwhatwesaw.ogg", "You want me to spill what we saw down there ?", Tools.color_galleries, 6)
	if time_elapsed == 2 + 102 :
		talk("res://voice/day2_5/burnitall.ogg", "You want me to burn it all ?", Tools.color_galleries, 6)
	if time_elapsed == 2 + 109 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "No. Not that. You know what’s down there.",Tools.color_me , 6)
	if time_elapsed == 2 + 116 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "If you speak too clearly… they won’t just silence you. You have to speak to them, but… differently.",Tools.color_me , 6)
	if time_elapsed == 2 + 123 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Remind	 them of what they’ve forgotten. What they know but don’t dare to name.",Tools.color_me , 6)
	if time_elapsed == 2 + 130 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Say it in tremors. In memories. But don’t say what it was.",Tools.color_me , 6)
	if time_elapsed == 2 + 137 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Not yet.",Tools.color_me , 6)
	if time_elapsed == 2 + 144 :
		talk("res://voice/day2_5/betheirmemory.ogg", "You want me to be their memory… without being their witness.", Tools.color_galleries, 6)
	if time_elapsed == 2 + 151 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Exactly", Tools.color_me, 6)
	if time_elapsed == 2 + 158 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "If the truth rises too fast, it’ll crush them. But if it seeps in slowly… It’ll wake them up..", Tools.color_me, 6)
	if time_elapsed == 2 + 165 :
		talk("res://voice/day2_5/wontdoitforyou.ogg", "…I’ll think about it. But I won’t do it for you.", Tools.color_galleries, 6)
	if time_elapsed == 2 + 172 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", " I know. That’s why I’m calling.", Tools.color_me, 6)
	if time_elapsed == 2 + 179 :
		talk_audio("res://Music&Sound/sound/phone-hang-up-46793.mp3",Tools.color_galleries)
		phone.activate = true
