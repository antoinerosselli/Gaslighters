extends Node

var time_elapsed = 0
var event_adv = 0
var gouv_color = Color(0.117647, 0.564706, 1, 1)

func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()

func talk(text,color, time):
	Tools.radio_text(text,time,color)
	Tools.add_journal(text,color)

func check_event_conditions():
	#helico event
	if time_elapsed == 5:
		talk("Tu veux hein", Color(1,0,0,1), 5)
		var sp = get_tree().get_first_node_in_group("pills")
		sp.spawn()
