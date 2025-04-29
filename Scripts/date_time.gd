#class_name DateTime extends Resource
extends Node

@export var day :int= 0 
@export_range(0,23) var hours :int= 0
@export_range(0,59) var minutes :int= 0

var delta_time :float= 0

func increase_time_minutes(delta_mins: float) -> void:
	delta_time += delta_mins
	if delta_time < 1: return
	
	var delta_as_int :int= int(delta_time)
	delta_time -= delta_as_int
	
	minutes += delta_as_int
	hours += int(minutes / 60)
	
	minutes = minutes % 60
	hours = hours % 24

func getHours():
	return hours
	
func getMinutes():
	return minutes
