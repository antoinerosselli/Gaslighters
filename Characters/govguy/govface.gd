extends StaticBody3D

@onready var spot_light_3d = $SpotLight3D
@onready var spot_light_3d_2 = $SpotLight3D2

func _on_timer_timeout():
	spot_light_3d.omni_range = 0
	spot_light_3d_2.omni_range = 0
	var aeom = Timer.new()
	aeom.wait_time = 0.1
	aeom.one_shot = true
	aeom.timeout.connect(_on_aeom_timeout)
	add_child(aeom)
	aeom.start()

func _on_aeom_timeout():
	spot_light_3d.omni_range = 1
	spot_light_3d_2.omni_range = 1
