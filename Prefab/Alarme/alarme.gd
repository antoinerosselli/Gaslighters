extends Node3D

@onready var label :Label3D= $Time
@export var auto_start: bool
@export var minute:int
@export var hour:int
@onready var audio_stream_player_3d = $AudioStreamPlayer3D

func _on_timer_timeout():
	if auto_start == true:
		minute += 1
		if minute >= 60:
			minute = 0
			hour += 1
		if hour >= 24:
			hour = 0	
		#label.text = "%02d:%02d" % [hour, minute]

func go_bip():
	audio_stream_player_3d.play()
