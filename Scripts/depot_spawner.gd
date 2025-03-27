extends Marker3D

@export var depot : PackedScene
@export var activation: bool = false
@onready var timer = $Timer

func _ready():
	timer.wait_time = randi() % 250 + 10
	print(timer.wait_time)

func _process(delta):
	if activation == true:
		print("is activate")
		activation = false
		timer.start()

func _on_timer_timeout():
	print("spawn")
	var ndepot = depot.instantiate()
	self.add_child(ndepot)
