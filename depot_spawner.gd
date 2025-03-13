extends Marker3D

@export var depot : PackedScene
@export var activation: bool = false
@onready var timer = $Timer

func _ready():
	timer.wait_time = randi() % 20 + 10

func _process(delta):
	if activation == true:
		activation = false
		print(timer.wait_time)
		print("depot en cours")
		timer.start()

func _on_timer_timeout():
	var ndepot = depot.instantiate()
	self.add_child(ndepot)
