extends CharacterBody3D

@onready var ray_cast_3d = $Camera3D/RayCast3D
@onready var timer = $CanvasLayer/Control/show_text/Timer
@onready var show_text = $CanvasLayer/Control/show_text
@onready var show_text_radio = $CanvasLayer/Control/show_text_radio
@onready var inventory = $CanvasLayer/Control/Inventory
@onready var logo_inter = $CanvasLayer/Control/Label
@onready var camera_3d = $Camera3D
@onready var icon = $CanvasLayer/Control/Icon
@onready var ptich = $Camera3D/ptich
@onready var popup_sure = $CanvasLayer/popup_sure
@onready var paused:Label = $CanvasLayer/Control/paused

#inventory
var on_inventory:bool = false
@onready var label = $CanvasLayer/Control/Inventory/Label
@onready var journal = $CanvasLayer/Control/Inventory/Panel

var dialogues_id:int = 0
var dialogues:Array = []
var read_dialogue = false

var sanity = 100
var use_radio:bool= false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var affect_by_gravity:bool = true
@export var can_move:bool = true

var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002
var camera_sensitivity = 0.04
var can_interact:bool = false

var crouch:bool = false

var item

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func dialogues_manager():
	show_text.text = dialogues[dialogues_id]
	Tools.add_journal(show_text.text, Color(0.881,0.48,0.145,1))
	read_dialogue = true
	var tmp_array = dialogues[dialogues_id].rsplit(" ", true, 1)
	timer.start(1 + (tmp_array.size() / 2))
	dialogues_id += 1

func _physics_process(delta):
	if camera_3d.current == true:
		if can_interact == true:
			logo_inter.visible = true
		elif can_interact == false:
			logo_inter.visible = false
				
		if dialogues.size() > dialogues_id:
			if dialogues[dialogues_id] != null && read_dialogue == false:
				dialogues_manager()
		else :
			dialogues = []
			dialogues_id = 0
		if affect_by_gravity == true :
			velocity.y += -gravity * delta
		var input = Input.get_vector("left", "right", "up", "down")
		var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
		velocity.x = movement_dir.x * speed
		velocity.z = movement_dir.z * speed
					
		if ray_cast_3d.is_colliding():
			item = ray_cast_3d.get_collider()
			if item != null:
				if item.has_method("interact"):
					can_interact = true
				else :
					can_interact = false
		else:
			item = null
			can_interact = false

		camera_joystick()
			
		if can_move == true:
			move_and_slide()
			
		if Input.is_action_just_pressed("interact") and can_interact == true:
			item.interact()
			item = null
			can_interact = false

func camera_joystick():
	var input_dir:Vector2 = Vector2(
		Input.get_joy_axis(0, 2),  
		Input.get_joy_axis(0, 3)
	)

	rotate_y(-input_dir.x * camera_sensitivity)
	$Camera3D.rotate_x(-input_dir.y * camera_sensitivity)
	$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))


func _input(event):
	if Input.is_action_just_pressed("pause"):
		Tools.call_pause()
	if Input.is_action_just_pressed("crouch") && can_move == true:
		if crouch == false:
			camera_3d.position.y -= 1.1
			speed -= 4
			crouch = true
		elif crouch == true:
			camera_3d.position.y += 1.1
			speed += 4
			crouch = false
	if Input.is_action_just_pressed("select"):
		on_inventory = !on_inventory
		if inventory.visible == false :
			inventory.visible = true
			icon.visible = false
		elif inventory.visible == true :
			inventory.visible = false
			icon.visible = true
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED && $Camera3D.current == true:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func on_hand():
	if ptich.visible == true:
		ptich.visible = false
	elif ptich.visible ==  false:
		ptich.visible = true

func _on_timer_timeout():
	read_dialogue = false
	show_text.text = ""
