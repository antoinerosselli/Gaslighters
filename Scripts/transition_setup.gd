extends Node

@onready var label = $Label
@onready var text_transi: String
@onready var ap = $AP

var next_scene: PackedScene

func transition(text, nscene):
	print(nscene)
	text_transi = text
	next_scene = nscene
	ap.play("fade_to_black")
	
func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "fade_to_black"):
		label.text = text_transi
		var timer = Timer.new()
		timer.wait_time = 3
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		timer.start()

func _on_timer_timeout():
	print("TRANSIIIIIIIIIIIIIII")
	print(next_scene)
	get_tree().change_scene_to_packed(next_scene)
