extends Node

var time_elapsed = 0
var pills = 1
var pills_eaten = 0
var PS

func _ready():
	PS = get_tree().get_first_node_in_group("pills")
	
func _on_timer_timeout():
	time_elapsed += 1
	if pills >= 10 : pills = 10 
	for i in range(pills):
		PS.spawn()

func eat_a_pills():
	pills += 1
	pills_eaten += 1
	if pills_eaten == 70:
		Tools.start_transition("You've lost your mind", preload("res://Scene/menu3D.tscn") )
	print(pills)
