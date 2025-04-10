extends Node

var time_elapsed = 0
var tmp_te = 5
var event_adv = 0
var gouv_color = Color(0.117647, 0.564706, 1, 1)

func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()

func talk_audio(odio):
	print(odio)
	var bouche = get_tree().get_first_node_in_group("talkers")
	bouche.set_stream(load(odio) as AudioStreamWAV)
	bouche.play()

func talk(odio, text,color, time):
	tmp_te += time
	print(tmp_te)
	talk_audio(odio)
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	if time_elapsed == 5:
		talk("res://Voice/day1_5/1. The men of principles.wav", "You and your team have accomplished something exceptional. Rock Valley needs people like you... men of principle, capable of doing the right thing.", gouv_color, 10)
	if time_elapsed == 15:
		talk("res://Voice/day1_5/2. A name in the city_s hystory.wav", "This is your recognition. A pension for life. An honorary title. A name in the city's history.", gouv_color, 7)
	if time_elapsed == 23:
		var anim = get_tree().get_first_node_in_group("animator")
		anim.play("slide_contrat")
		talk("res://Voice/day1_5/3. intelligent men.wav", "Naturally, an intelligent man knows that there are some truths... that are best kept to oneself.", gouv_color, 7)
	if time_elapsed == 32:
		talk("res://Voice/day1_5/4. For prosperity.wav", "Why spread panic? You've seen the prosperity this mine brings. Rock Valley is growing. Families are living better. The town has never been so prosperous.", gouv_color, 12)
	if time_elapsed == 45:
		talk("res://Voice/day1_5/5. Go home a hero.wav", "Just sign. And you can go home as a free man. As a hero.", gouv_color, 7)
	if time_elapsed == 53:
		talk("res://Voice/day1_5/6. Pragmatic men.wav", "Don't tell me you're having second thoughts. You're a pragmatic man. It's best they don't worry about... things they can't understand.", gouv_color, 10)
	if time_elapsed == 65:
		var sp = get_tree().get_first_node_in_group("pills")
		sp.spawn()
		talk("res://Voice/day1_5/Know to shut up.wav", "A hero knows when to speak... and when to shut up.", gouv_color, 10)
