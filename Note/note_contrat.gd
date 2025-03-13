extends Control


func _physics_process(_delta):
	if Input.is_action_just_pressed("close"):
		Tools.note_close(self,Tools.get_player())
