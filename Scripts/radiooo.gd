extends Node3D

@onready var audioStream = $AudioStreamPlayer3D
var bruitBlanc :AudioStreamWAV= load("res://Music&Sound/NewStatic.wav")

func _ready():
	audioStream.play()

func _process(_data):
	var player = Tools.get_player()
	var audioMainStream = self.get_child(1)
	if player.use_radio == true:
		radio_usage()
	
	var _knobCurrentVal :float= Radio.getValue()
	if audioMainStream.get_child(0).playing == false and audioMainStream.playing == false:
		audioMainStream.set_stream(bruitBlanc)
		audioMainStream.play()
		print("Currently playing : bruit blanc")
	elif audioMainStream.get_child(0).playing == true and audioMainStream.playing == true:
		print("Currently playing : NOT BRUIT BLANC")
		audioMainStream.stop()


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
		player.set_interaction(false, null)
		Tools.change_lesinputs("player")
		player_icon.visible = true
		player_use.visible = true
		player.use_radio = false
		player_camera.current = true
		radio_camera.current = false
