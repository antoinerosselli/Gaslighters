extends Control
@onready var blue_radio : AnimatedSprite2D = $BlueRadio
@onready var green_radio : AnimatedSprite2D = $GreenRadio
@onready var red_radio : AnimatedSprite2D = $RedRadio
@onready var special_radio = $SpecialRadio

func _on_blue_radio_visibility_changed():
	if blue_radio.is_visible_in_tree():
		blue_radio.play("default")

func _on_red_radio_visibility_changed():
	if red_radio.is_visible_in_tree():
		red_radio.play("default")

func _on_green_radio_visibility_changed():
	if green_radio.is_visible_in_tree():
		green_radio.play("default")

func _on_special_radio_visibility_changed():
	if special_radio.is_visible_in_tree():
		special_radio.play("default")
