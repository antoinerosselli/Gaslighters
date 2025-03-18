extends Node3D

@onready var audioStream = $AudioStreamPlayer3D

func _ready():
	audioStream.play()

func _process(_data):
	var player = Tools.get_player()
	if player.use_radio == true:
		radio_usage()
		
	var knobCurrentVal :float= Radio.getValue()


func _on_audio_stream_player_3d_finished() -> void:
	audioStream.play()
	
func radio_usage():
	if Radio.getValue() < 0: Radio.setValue(0)
	if Radio.getValue() > 100: Radio.setValue(100)
	
	if Input.is_action_just_pressed("close"):
		var player = Tools.get_player()
		var radioObj = get_tree().get_first_node_in_group("radio")
		var radio_camera = radioObj
		var player_camera = player.get_node("Camera3D")
		var player_icon = player.get_node("CanvasLayer/Control/Icon")
		var player_use = player.get_node("CanvasLayer/Control/Label")
		Tools.change_lesinputs("player")
		player_icon.visible = true
		player_use.visible = true
		player.use_radio = false
		player_camera.current = true
		radio_camera.current = false
