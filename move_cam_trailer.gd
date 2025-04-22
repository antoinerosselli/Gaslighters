extends Camera3D

@export var move_speed := 5.0
@export var look_sensitivity := 0.1

var rotation_x := 0.0
var rotation_y := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().get_first_node_in_group("canvas").visible = false

func _input(event):
	if event is InputEventMouseMotion:
		rotation_x -= event.relative.y * look_sensitivity
		rotation_y -= event.relative.x * look_sensitivity
		rotation_x = clamp(rotation_x, -90, 90)
		rotation_degrees = Vector3(rotation_x, rotation_y, 0)
	elif event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			move_speed += 0.5
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			move_speed -= 0.5
	elif event is InputEventKey and event.is_action_pressed("close"):
		get_tree().get_first_node_in_group("canvas").visible = true
		queue_free()

func _process(delta):
	var dir := Vector3.ZERO
	if Input.is_action_pressed("up"):
		dir -= transform.basis.z
	if Input.is_action_pressed("down"):
		dir += transform.basis.z
	if Input.is_action_pressed("left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("right"):
		dir += transform.basis.x
	if Input.is_action_pressed("interact"):
		dir += transform.basis.y
	if Input.is_action_pressed("crouch"):
		dir -= transform.basis.y

	position += dir.normalized() * move_speed * delta
