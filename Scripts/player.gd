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
@onready var detect_value = $CanvasLayer/eyecontrol/TextureProgressBar
@onready var screamer_control = $CanvasLayer/ScreamerControl
@onready var screamer_sound = $CanvasLayer/ScreamerControl/AudioStreamPlayer3D
@onready var scream = false
@onready var control = $CanvasLayer/Control
@onready var color_rect = $CanvasLayer/ColorRect

#inventory
var on_inventory:bool = false
@onready var label = $CanvasLayer/Control/Inventory/Label

var dialogues_id:int = 0
var dialogues:Array = []
var read_dialogue = false

var sanity = 100
var use_radio:bool= false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var affect_by_gravity:bool = true
@export var can_move:bool = true
@export var radioradar:bool = true

var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002
var camera_sensitivity = 0.04
var can_interact:bool = false

var crouch:bool = false

var item
var storeItemUsed :StaticBody3D= null
var isInteracting :bool= false
var lastUsedItem :StaticBody3D= null #ya probablement mieux mais jpp là

func _ready():
	Tools.change_lesinputs("player")
	if radioradar == false :
		get_tree().get_first_node_in_group("radarradio").visible = false
	if Data.get_radio("G") == 1:
		var govfm = get_tree().get_first_node_in_group("govfm")
		govfm.visible = true
	if Data.get_radio("B") == 1:
		var bellefm = get_tree().get_first_node_in_group("bellefm")
		bellefm.visible = true
	if Data.get_radio("M") == 1:
		var fanaticfm = get_tree().get_first_node_in_group("fanaticfm")
		fanaticfm.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func dialogues_manager():
	show_text.text = dialogues[dialogues_id]
	Tools.add_journal(show_text.text, Color(0.881,0.48,0.145,1))
	read_dialogue = true
	var tmp_array = dialogues[dialogues_id].rsplit(" ", true, 1)
	timer.start(1 + (tmp_array.size() / 1.2))
	dialogues_id += 1

func _physics_process(delta):
	var scaled_sanity = 0.3 - 0.0027 * sanity
	if scaled_sanity > 0.3 :
		scaled_sanity = 0.3
	if scaled_sanity < 0.03 :
		scaled_sanity = 0.03
	color_rect.get_material().set_shader_parameter('noise_amount', scaled_sanity)
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
			if item.name == "RadioObj1": #c'est moche, ca devrait marcher?
				set_interaction(true, item)
			item = null
			can_interact = false

func is_interacting_with() -> StaticBody3D:
	if lastUsedItem:
		return lastUsedItem
	elif lastUsedItem == null and storeItemUsed != null:
		return storeItemUsed
	else:
		return null
	

func is_interacting() -> bool:
	return isInteracting

func set_interaction(status :bool, item: StaticBody3D = null):
	isInteracting = status
	lastUsedItem = storeItemUsed
	storeItemUsed = item

func camera_joystick():
	var input_dir:Vector2 = Vector2(
		Input.get_joy_axis(0, 2),  
		Input.get_joy_axis(0, 3)
	)

	rotate_y(-input_dir.x * camera_sensitivity)
	$Camera3D.rotate_x(-input_dir.y * camera_sensitivity)
	$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))


func _input(event):
	if Input.is_action_just_pressed("next_level"):
		if Data.get_level() == 1:
			Tools.start_transition("DAY 2", load("res://Scene/Days/Day2/scene_day_2.tscn") as PackedScene)
		if Data.get_level() == 2:
			Tools.start_transition("DAY 3", load("res://Scene/Days/Day3/scene_day_3.tscn") as PackedScene)
		if Data.get_level() == 3:
			Tools.start_transition("DAY 4", load("res://Scene/Days/Day4/scene_day_4.tscn") as PackedScene)
		if Data.get_level() == 4:
			Tools.start_transition("", load("res://Scene/final_days/scene_final.tscn") as PackedScene)
	if Input.is_action_just_pressed("no_ui"):
		control.visible = !control.visible
	if Input.is_action_just_pressed("pause") && inventory.visible == false && get_tree().get_first_node_in_group("notenote") == null :
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
			Tools.change_lesinputs("inventory")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			inventory.visible = true
			icon.visible = false
		elif inventory.visible == true :
			Tools.change_lesinputs("player")
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
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

func detect():
	detect_value.value += 34
	if detect_value.value >= 100 && scream == false:
		detect_value = 0
		screamer_control.visible = true
		scream = true
		screamer_sound.play()
		
func _on_audio_stream_player_3d_finished():
	screamer_control.visible = false
	var evman = get_tree().get_first_node_in_group("event_manager")
	var ani =  get_tree().get_first_node_in_group("animamanager")
	evman.time_elapsed = 223
	detect_value.value = 0
	scream = false
	ani.play("RESET")
	
func unstuck():
	var sp_point = get_tree().get_first_node_in_group("player_spawn")
	if sp_point == null : 
		return
	self.position = sp_point.position
