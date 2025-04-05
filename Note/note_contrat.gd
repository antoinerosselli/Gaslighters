extends Control


func _physics_process(_delta):
	if Input.is_action_just_pressed("close"):
		Tools.sound_now(Tools.get_player(), load("res://Music&Sound/sound/paperopen.mp3") as AudioStreamMP3)
		Tools.note_close(self,Tools.get_player())
