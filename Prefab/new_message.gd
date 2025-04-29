extends Panel

@onready var label = $Label
@onready var animation_player = $AnimationPlayer

func newmessage(newlabel):
	label.text = newlabel
	animation_player.play("go_in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "go_in":
		animation_player.play("go_out")
