extends StaticBody3D

@onready var animation_player = $AnimationPlayer

func new_letter():
	Tools.sound_now(self,load("res://Music&Sound/door-knocking-175163.mp3") as AudioStream)
	animation_player.play("slide_letter")
