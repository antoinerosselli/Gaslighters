extends Node

var time_elapsed = 0
var event_adv = 0


func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()
	
func check_event_conditions():
	#helico event
	if time_elapsed == 20:
		print("helico event")
		Tools.colis_departure()
		Tools.door_letter()
		Tools.start_sound("res://Music&Sound/helicopter-sound-effect-241421.mp3")
	#remove alarm
	if time_elapsed == 50 :
		print("remove alarm")
		var alarm = get_tree().get_first_node_in_group("alarm")
		alarm.stop()
	#helicot event drop
	if time_elapsed == 280 :
		print("helico drop")
		Tools.start_sound("res://Music&Sound/helicopter-sound-effect-241421.mp3")
	
	if time_elapsed == 350:
		print("end of the day")
		Tools.eotd()
