extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var colis_spawner = $colis_spawner

func _ready():
	animation_player.play("go_to_home")	

func _on_timer_timeout():
	print("next anim")
	animation_player.play("go_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "go_to_home" :
		colis_spawner.drop_the_colis()
		var timer = Timer.new()
		timer.wait_time = 3
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		timer.start()
	if anim_name == "go_out":
		self.queue_free()
