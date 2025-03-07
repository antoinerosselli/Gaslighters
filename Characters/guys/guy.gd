extends StaticBody3D

@onready var spot_light_3d = $face/SpotLight3D
@onready var spot_light_3d_2 = $face/SpotLight3D2
@onready var timer = $Timer
@export var guy_talk: bool = false
@onready var animation_player = $AnimationPlayer

func _ready():
	if guy_talk == true:
		self.add_to_group("guy_talk",true)

func _on_timer_timeout():
	timer.wait_time = randi() % 6 + 1
	var aeom = Timer.new()
	aeom.wait_time = 0.1
	aeom.one_shot = true
	aeom.timeout.connect(_on_aeom_timeout)
	add_child(aeom)
	aeom.start()

func _on_aeom_timeout():
	animation_player.play("cligne")
