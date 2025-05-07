extends Node

var time_elapsed = 0
var tmp_te = 5
var event_adv = 0
var me_color = Color(1, 0.54902, 0, 1)
var Fanatic_color = Color(0.545098, 0, 0, 1)
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
	if text_color == me_color:
		return
	var bouche = get_tree().get_first_node_in_group("phonesound")
	bouche.set_stream(load(odio) as AudioStream)
	bouche.play()
	
func talk(odio, text,color, time):
	talk_audio(odio,color)
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	if time_elapsed == 5 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "It’s me.",me_color , 6)
	if time_elapsed == 11 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Don’t say anything. Not here. Not on this line.",me_color , 6)
	if time_elapsed == 18 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "I’m sorry.",me_color , 6)
	if time_elapsed == 25 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "For everything. For the silence. For the trial. For the years.",me_color , 6)
	if time_elapsed == 32 :
		talk("res://voice/day2_5/Iknewyoucall.ogg", "I knew you’d call.",Fanatic_color , 6)
	if time_elapsed == 39 :
		talk("res://voice/day2_5/idontneedyourapo.ogg", "I don’t need your apologies.",Fanatic_color , 6)
	if time_elapsed == 46 :
		talk("res://voice/day2_5/whatdoyouwant.ogg", "What do you want?",Fanatic_color , 6)
	if time_elapsed == 53 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "I want you to come back.",me_color , 6)
	if time_elapsed == 60 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Not for me. For them.",me_color , 6)
	if time_elapsed == 67 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "For the ones who used to listen.",me_color , 6)
	if time_elapsed == 74 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Your voice... it gave them air.",me_color , 6)
	if time_elapsed == 81 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "You need to turn your radio back on.",me_color , 6)
	if time_elapsed == 88 :
		talk("res://voice/day2_5/andsaywhat.ogg", "And say what ?", Fanatic_color, 6)
	if time_elapsed == 95 :
		talk("res://voice/day2_5/spillwhatwesaw.ogg", "You want me to spill what we saw down there ?", Fanatic_color, 6)
	if time_elapsed == 102 :
		talk("res://voice/day2_5/burnitall.ogg", "You want me to burn it all ?", Fanatic_color, 6)
	if time_elapsed == 109 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "No. Not that. You know what’s down there.",me_color , 6)
	if time_elapsed == 116 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "If you speak too clearly… they won’t just silence you. You have to speak to them, but… differently.",me_color , 6)
	if time_elapsed == 123 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Remind	 them of what they’ve forgotten. What they know but don’t dare to name.",me_color , 6)
	if time_elapsed == 130 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Say it in tremors. In memories. But don’t say what it was.",me_color , 6)
	if time_elapsed == 137 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Not yet.",me_color , 6)
	if time_elapsed == 144 :
		talk("res://voice/day2_5/betheirmemory.ogg", "You want me to be their memory… without being their witness.", Fanatic_color, 6)
	if time_elapsed == 151 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "Exactly", me_color, 6)
	if time_elapsed == 158 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", "If the truth rises too fast, it’ll crush them. But if it seeps in slowly… It’ll wake them up..", me_color, 6)
	if time_elapsed == 165 :
		talk("res://voice/day2_5/wontdoitforyou.ogg", "…I’ll think about it. But I won’t do it for you.", Fanatic_color, 6)
	if time_elapsed == 172 :
		talk("res://Music&Sound/sound/alarmpills_sound.mp3", " I know. That’s why I’m calling.", me_color, 6)
		phone.activate = true
