extends CheckBox

func _ready():
	button_pressed = Tools.daltonian_mode

func _on_toggled(toggled_on):
	Tools.toggle_daltonian_mode()
