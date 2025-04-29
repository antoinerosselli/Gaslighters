extends Sprite3D

@onready var allume:bool = false

func _ready():
	camcam()
	nocamcam()

func yescamcam():
	visible = true
	
func nocamcam():
	visible = false 

func camcam():
	var cam = get_tree().get_first_node_in_group("camerasecure")
	var viewport = cam.get_parent()
	var textureU = viewport.get_texture()  # Récupérer la texture du viewport
	self.texture = textureU  # Appliquer la texture sur le Sprite3D	
