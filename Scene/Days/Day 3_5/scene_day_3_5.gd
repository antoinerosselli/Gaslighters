extends Node3D
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	get_tree().paused = false


func _on_audio_stream_player_finished():
	audio_stream_player.play()
