extends Node3D
@onready var panel = $Camera3D/Control/Panel


func _on_take_suit_pressed():
	panel.visible = true

func _on_let_the_suit_pressed():
	panel.visible = true

func _on_no_pressed():
	panel.visible = false

func _on_yes_pressed():
	Tools.start_transition("", load("res://Scene/final_days/end_cinema.tscn") as PackedScene)
