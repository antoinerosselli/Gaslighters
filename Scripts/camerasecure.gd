extends Sprite3D

@onready var allume:bool = false

func _ready():
	camcam()
	nocamcam()

func yescamcam():
	visible = true
	
func nocamcam():
	print("nocam")
	visible = false 

func camcam():
	print("ready cam")
	var cam = get_tree().get_first_node_in_group("camerasecure")
	var viewport = cam.get_parent()
	var texture = viewport.get_texture()  # Récupérer la texture du viewport
	self.texture = texture  # Appliquer la texture sur le Sprite3D	
