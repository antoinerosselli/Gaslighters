extends Control

func _ready():
	Tools.paused_game()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_option_pressed():
	Tools.call_options()
