extends StaticBody3D

@export var prefab_conserve: PackedScene
@onready var marker_3d = $Marker3D
@onready var audio_stream_player_3d = $AudioStreamPlayer3D

func spawn_conserve(quantity):
	audio_stream_player_3d.play()
	if not prefab_conserve:
		return
	
	for i in range(quantity):
		var conserve = prefab_conserve.instantiate() 
		conserve.position = marker_3d.position  
		add_child(conserve) 
