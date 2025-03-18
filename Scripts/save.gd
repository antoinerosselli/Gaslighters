extends Node

@export var savefile_path : String = "res://Save/save.txt"
@onready var level : int

func _ready():
	var savefile = FileAccess.open(savefile_path, FileAccess.READ)
	if savefile:
		var content = savefile.get_line()  # Lire la première ligne du fichier
		if content.length() > 0:
			level = content[0].to_int()  # Récupérer le premier caractère
		savefile.close()  # Toujours fermer le fichier après avoir fini de l'utiliser
	else:
		print("Failed to open file:", savefile_path)
	
func save_level(nlevel):
	var savefile = FileAccess.open(savefile_path, FileAccess.WRITE)
	if savefile:
		print("Saving level: " + str(nlevel))
		savefile.store_string(str(nlevel))
		savefile.close()
	else:
		print("Failed to open file for writing:", savefile_path)

func actual_level() -> int:
	return level

func set_level(nlevel):
	save_level(nlevel)
	level = nlevel
