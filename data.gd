extends Node

var level : int
var RadioGov : int
var RadioBelle : int
var RadioGalleries : int
var journal_text: Array = []
var daltone_mode: bool
var doornumber:int 
var clearspots:int

func _ready():
	level = 0
	RadioGov = 0
	RadioBelle = 0
	RadioGalleries = 0
	daltone_mode = false
	doornumber = 0
	clearspots = 0
	load_data()
	if daltone_mode == true:
		print("ayo")
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
	}
	return save_dict

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
