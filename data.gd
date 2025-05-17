extends Node

var level : int
var RadioGov : int
var RadioBelle : int
var RadioGalleries : int
var journal_text: Array = []
var daltone_mode: bool
var doornumber:int 
var clearspots:int
var food:int
var input_map_data: Dictionary = {}

func _ready():
	level = 0
	RadioGov = 0
	RadioBelle = 0
	RadioGalleries = 0
	daltone_mode = false
	doornumber = 0
	clearspots = 0
	food = 0
	input_map_data = {}
	load_data()
	if daltone_mode == true:
		Tools.toggle_daltonian_mode()

func save():
	var save_dict = {
		"level" : level,
		"RadioGov" : RadioGov,
		"RadioBelle" : RadioBelle,
		"RadioGalleries" : RadioGalleries,
		"journal_text" : journal_text,
		"daltone_mode" : daltone_mode,
		"doornumber" : doornumber,
		"clearspots" : clearspots,
		"food": food,
		"inputs": input_map_data,
	}
	return save_dict

func set_inputs(ninputs):
	input_map_data = ninputs
	
	if ninputs.is_empty():
		print("ninputs est vide, chargement des touches par défaut.")
		input_map_data = {
			"up": "W",
			"down": "S",
			"left": "A",
			"right": "D",
			"interact": "E",
		}
	
	InputMap.action_erase_events("up")
	InputMap.action_add_event("up", key_adder(input_map_data["up"]))
	
	InputMap.action_erase_events("down")
	InputMap.action_add_event("down", key_adder(input_map_data["down"]))
	
	InputMap.action_erase_events("left")
	InputMap.action_add_event("left", key_adder(input_map_data["left"]))
	
	InputMap.action_erase_events("right")
	InputMap.action_add_event("right", key_adder(input_map_data["right"]))
	
	InputMap.action_erase_events("interact")
	InputMap.action_add_event("interact", key_adder(input_map_data["interact"]))
	save_data()


	
func get_inputs():
	load_data()
	print(input_map_data)
	
	input_map_data = {
		"up" : key_finder(InputMap.action_get_events("up")),
		"down" : key_finder(InputMap.action_get_events("down")),
		"left" : key_finder(InputMap.action_get_events("left")),
		"right" : key_finder(InputMap.action_get_events("right")),
		"interact" : key_finder(InputMap.action_get_events("interact")),
	}
	print(input_map_data)
	return input_map_data

func set_food(nfood:int):
	food = nfood
	save_data()

func get_food():
	return food

func add_spots():
	clearspots += 1
	if clearspots == 10:
		SteamControl.unlock_achievement("ACH_SPOTS")

func add_door():
	doornumber += 1
	if doornumber == 100:
		SteamControl.unlock_achievement("ACH_DOOR")

func set_daltone(status):
	daltone_mode = status
	save_data()

func get_daltone():
	return daltone_mode

func set_radio(name_radio):
	if name_radio == "G":
		RadioGov = 1
	elif name_radio == "B":
		RadioBelle = 1
	elif name_radio == "M":
		RadioGalleries = 1
	save_data()

func get_radio(name_radio):
	if name_radio == "G":
		return RadioGov
	elif name_radio == "B":
		return RadioBelle
	elif name_radio == "M":
		return RadioGalleries

func set_level(nlevel):
	level = nlevel
	save_data()

func get_level():
	return level

func get_journal():
	return journal_text

func key_finder(action):
	var key_action = action[0]
	var key_string = OS.get_keycode_string(key_action.keycode)
	return str(key_string)

func key_adder(text):
	var key_string = text.strip_edges()
	var keycode = OS.find_keycode_from_string(key_string)
	if keycode != 0:
		var event := InputEventKey.new()
		event.keycode = keycode
		event.pressed = true
		return event
	else:
		print("Touche invalide :", key_string)

func save_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var node_data = save()
	var json_string = JSON.stringify(node_data)
	save_file.store_line(json_string)

func load_data():
	if not FileAccess.file_exists("user://savegame.save"):
		save_data()
		return
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var _parse_result = json.parse(json_string)
		var node_data = json.get_data()
		level = node_data.get("level", 0)
		RadioGov = node_data.get("RadioGov", 0)
		RadioBelle = node_data.get("RadioBelle", 0)
		RadioGalleries = node_data.get("RadioGalleries", 0)
		journal_text = node_data.get("journal_text", [])
		daltone_mode = node_data.get("daltone_mode", 0)
		doornumber = node_data.get("doornumber", 0) 
		food = node_data.get("food", 0) 
		input_map_data = node_data.get("inputs", {})
		set_inputs(input_map_data)
