extends Control

@onready var option_button = $Panel/Brightness/OptionButton
@onready var rebind_keys_panel = $RebindKeys_panel

func _ready():
	print("OPTION READY")
	option_button.selected = Tools.lum
	change_lum()
	
func _on_close_pressed():
	self.queue_free()

func _on_option_button_item_selected(index):
	var env = get_tree().get_first_node_in_group("env")
	option_button.selected = index
	Tools.lum = index
	if env == null:
		return
	if index == 0:
		env.environment.set_adjustment_brightness(0.3)
	elif index == 1:
		env.environment.set_adjustment_brightness(0.7)
	elif index == 2:
		env.environment.set_adjustment_brightness(1.1)
	elif index == 3:
		env.environment.set_adjustment_brightness(1.6)
	elif index == 4:
		env.environment.set_adjustment_brightness(2.3)

func change_lum():
	var env = get_tree().get_first_node_in_group("env")
	if env == null:
		return
	if Tools.lum == 0:
		env.environment.set_adjustment_brightness(0.3)
	elif Tools.lum == 1:
		env.environment.set_adjustment_brightness(0.7)
	elif Tools.lum == 2:
		env.environment.set_adjustment_brightness(1.1)
	elif Tools.lum == 3:
		env.environment.set_adjustment_brightness(1.6)
	elif Tools.lum == 4:
		env.environment.set_adjustment_brightness(2.3)

func _on_button_pressed():
	var player = Tools.get_player()
	if player == null :
		return	
	player.unstuck()

func _on_rebind_pressed():
	rebind_keys_panel.visible = true
