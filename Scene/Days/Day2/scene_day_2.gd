extends Node3D
var asp:bool = false
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	get_tree().paused = false
	Data.set_level(2)
	UniqueTrait.elec = true
	Tools.set_elec(60)
	var codesr = get_tree().get_first_node_in_group("codesr")
	codesr.activate = false
	Radio.setValue(0)


func _on_special_radio_visibility_changed():
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	if asp == false:
		audio_stream_player.play()
		asp = true
