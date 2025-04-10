extends Control

func _on_yesbutton_pressed():
	self.visible = false
	Tools.go_to_expe()

func _on_nobutton_pressed():
	Tools.paused_game()
	self.visible = false

func _on_visibility_changed():
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE	
		Tools.paused_game()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
