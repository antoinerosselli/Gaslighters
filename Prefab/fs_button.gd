extends CheckBox

func _ready():
	if DisplayServer.window_get_mode() == 3:
		self.button_pressed = true
	if DisplayServer.window_get_mode() == 1:
		self.button_pressed = false

func _on_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
