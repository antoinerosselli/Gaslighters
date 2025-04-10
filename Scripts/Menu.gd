extends Control

@onready var credits = $credits
@onready var continue_button = $continue_button

func _ready():
	Data.load_data()
	Radio.setValue(0.0)
	if Data.get_level() > 0:
		continue_button.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_quit_button_pressed():
	get_tree().quit()

func _on_credit_pressed():
	credits.visible = true

func _on_close_pressed():
	credits.visible = false

func _on_play_button_pressed():
	var menusound = get_tree().get_first_node_in_group("musicmenu")
	menusound.stop()
	Data.set_level(1)
	Tools.start_transition("1 a.m Rock Valley new miners area ",load("res://Scene/Days/Day1/scene_day_1.tscn") as PackedScene)

func _on_options_button_pressed():
	Tools.call_options()

func _on_continue_button_pressed():
	var menusound = get_tree().get_first_node_in_group("musicmenu")
	menusound.stop()
	if Data.get_level() == 1:
		Tools.start_transition("1 a.m Rock Valley new miners area ",load("res://Scene/Days/Day1/scene_day_1.tscn") as PackedScene)
	if Data.get_level() == 2:
		Tools.start_transition("Day 2", load("res://Scene/Days/Day2/scene_day_2.tscn") as PackedScene)

func _on_button_pressed():
	var thelamp = get_tree().get_first_node_in_group("lampmenu")
	if thelamp.omni_range == 1:
		thelamp.omni_range = 0
	elif thelamp.omni_range == 0:
		thelamp.omni_range = 1
