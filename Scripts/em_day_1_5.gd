extends Node

var time_elapsed = 0
var event_adv = 0
var gouv_color = Color(0.117647, 0.564706, 1, 1)

func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()

func talk_audio():
	var guy = get_tree().get_first_node_in_group("guy_talk")
	var audio = guy.get_child(0)
	audio.set_stream(load("res://Music&Sound/explosion-47821.mp3") as AudioStreamMP3)
	audio.play()

func talk(text,color, time):
	talk_audio()
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	if time_elapsed == 5:
		talk("You and your team have accomplished something exceptional. Rock Valley needs people like you... men of principle, capable of doing the right thing.", gouv_color, 5)
	if time_elapsed == 11:
		talk("This is your recognition. A pension for life. An honorary title. A name in the city's history.", gouv_color, 5)
	if time_elapsed == 17:
		var anim = get_tree().get_first_node_in_group("animator")
		anim.play("slide_contrat")
		talk("Naturally, an intelligent man knows that there are some truths... that are best kept to oneself.", gouv_color, 5)
	if time_elapsed == 23:
		talk("Why spread panic? You've seen the prosperity this mine brings. Rock Valley is growing. Families are living better. The town has never been so prosperous.", gouv_color, 5)
	if time_elapsed == 29:
		talk("Just sign. And you can go home as a free man. As a hero.", gouv_color, 5)
		var sp = get_tree().get_first_node_in_group("pills")
		sp.spawn()
	if time_elapsed == 35:
		talk("Don't tell me you're having second thoughts. You're a pragmatic man. Your colleagues? They'll keep working, whatever happens. It's best they don't worry about... things they can't understand.", gouv_color, 5)
	if time_elapsed == 48:
		talk("A hero knows when to speak... and when to shut up.", gouv_color, 10)
