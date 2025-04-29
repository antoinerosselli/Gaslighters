extends Node

@export var savefile_path : String = "res://Save/save.txt"
@export var radiofile_path : String = "res://Save/radio.txt"
@onready var level : int
@onready var RadioGov : int
@onready var RadioBelle : int
@onready var RadioGalleries : int

func _ready():
	var savefile = FileAccess.open(savefile_path, FileAccess.READ)
	var radiofile = FileAccess.open(radiofile_path, FileAccess.READ)
	if radiofile:
		var content = radiofile.get_line()
		if content.length() > 0:
			RadioGov = content[1].to_int()  
			RadioBelle = content[3].to_int()
			RadioGalleries = content[5].to_int()
		radiofile.close()  
	if savefile:
		var content = savefile.get_line()  
		if content.length() > 0:
			level = content[0].to_int() 
		savefile.close()  
	else:
		print("Failed to open file:", savefile_path)
	
func save_level(nlevel):
	var savefile = FileAccess.open(savefile_path, FileAccess.WRITE)
	if savefile:
		savefile.store_string(str(nlevel))
		savefile.close()
	else:
		print("Failed to open file for writing:", savefile_path)

func save_radio():
	var savefile = FileAccess.open(radiofile_path, FileAccess.WRITE)
	if savefile:
		savefile.store_string("G" + str(RadioGov) + "B" + str(RadioBelle) + "M" + str(RadioGalleries))
		savefile.close()
	else:
		print("Failed to open file for writing:", savefile_path)

func actual_level() -> int:
	return level

func set_level(nlevel):
	save_level(nlevel)
	level = nlevel
	
func discover_radio(name_radio):
	if name_radio == "G":
		RadioGov = 1
	elif name_radio == "B":
		RadioBelle = 1
	elif name_radio == "M":
		RadioGalleries = 1
	save_radio()
