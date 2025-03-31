extends Node

var time_elapsed = 0
var event_adv = 0
var gouv_color = Color(0.117647, 0.564706, 1, 1)

func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()

func talk_audio(odio):
	var guy = get_tree().get_first_node_in_group("guy_talk")
	var audio = guy.get_child(0)
	audio.set_stream(load(odio) as AudioStreamMP3)
	audio.play()

func talk(odio, text,color, time):
	talk_audio(odio)
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	if time_elapsed == 5:
		print("gogo")
		talk("res://Voice/day1_5/1. The men of principles.wav", "You and your team have accomplished something exceptional. Rock Valley needs people like you... men of principle, capable of doing the right thing.", gouv_color, 5)
	if time_elapsed == 11:
		talk("res://Voice/day1_5/2. A name in the city_s hystory.wav", "This is your recognition. A pension for life. An honorary title. A name in the city's history.", gouv_color, 5)
	if time_elapsed == 17:
		var anim = get_tree().get_first_node_in_group("animator")
		anim.play("slide_contrat")
		talk("res://Voice/day1_5/3. intelligent men.wav", "Naturally, an intelligent man knows that there are some truths... that are best kept to oneself.", gouv_color, 5)
	if time_elapsed == 23:
		talk("res://Voice/day1_5/4. For prosperity.wav", "Why spread panic? You've seen the prosperity this mine brings. Rock Valley is growing. Families are living better. The town has never been so prosperous.", gouv_color, 5)
	if time_elapsed == 29:
		talk("res://Voice/day1_5/5. Go home a hero.wav", "Just sign. And you can go home as a free man. As a hero.", gouv_color, 5)
		var sp = get_tree().get_first_node_in_group("pills")
		sp.spawn()
	if time_elapsed == 35:
		talk("res://Voice/day1_5/6. Pragmatic men.wav", "Don't tell me you're having second thoughts. You're a pragmatic man. It's best they don't worry about... things they can't understand.", gouv_color, 5)
	if time_elapsed == 48:
		talk("res://Voice/day1_5/Know to shut up.wav", "A hero knows when to speak... and when to shut up.", gouv_color, 10)
