extends Node

var level:int

func _ready():
	level = 0
	load_data()

func save():
	var save_dict = {
		"level" : level,
	}
	return save_dict

func set_level(nlevel):
	level = nlevel
	save_data()

func get_level():
	return level

func save_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var node_data = save()
	var json_string = JSON.stringify(node_data)
	save_file.store_line(json_string)

func load_data():
	if not FileAccess.file_exists("user://savegame.save"):
		FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var _parse_result = json.parse(json_string)
		var node_data = json.get_data()
		level = node_data["level"]
