extends Sprite3D

func _ready():
	if Tools.TES == false :
		self.texture = load("res://Sprite/newspapernosuit.png") as Texture2D
	if Tools.TES == true :
		self.texture = load("res://Sprite/newspapersuit.png") as Texture2D
