extends Node

@export_category("Depots Manager")
@export var DANGER_LEVEL: int
@onready var depots = []
@onready var animation_player = $"../AnimationPlayer"

@export_category("Events Manager")

@export_category("Radio Manager")
#gouv
var gouv_color = Color(0.117647, 0.564706, 1, 1)
var gouv_time = 0
#belle
var belle_color = Color(1, 0.0784314, 0.576471, 1)
var belle_time = 0
#Fanatic
var Fanatic_color = Color(0.545098, 0, 0, 1)
var Fanatic_time = 0
var ones: bool = false

#TIMER
var time_elapsed = 0

#DAY03 ELEMENTS
var is_in_fog :bool = false
var is_escaping :bool = false
static var msg_status :int= 0
@export var Ceilling_Fan :MeshInstance3D
@export var Start_Node :Node3D
@export var Fog_Door :FogVolume
@export var Door_expe :CollisionShape3D
@export var Lampadaires :Node3D

func _process(_delta):
	if ones == false:
		if Radio.getFrequency() == 4:
			Tools.event_journal_ok(0, false)
			ones = true
	
	if ones == true and Radio.getFrequency() == 4:
		Radio.setDisplay(1,"")
		Radio.setDisplay(2,"EscAPE")
		Ceilling_Fan.transform.basis = Basis(Vector3(0,1,0), -0.03) * Ceilling_Fan.transform.basis
		is_escaping = true #discutable
	
	elif Radio.getDisplay(2) != "FM":
		Radio.setDisplay(2,"FM")
	
	if Tools.get_player().position:
		return
	
	#if is_escaping == true:
		#for child in Lampadaires:
			#

func _on_timer_timeout():
	time_elapsed += 1
	(time_elapsed)
	check_event_conditions()

func check_event_conditions():
	if time_elapsed % 30 == 0:
		find_and_remove(Start_Node, 1)
	
	if time_elapsed % 3 == 0: #The fog is coming
		Fog_Door.scale += Vector3(0.2,0.001,0.2)
	
	if time_elapsed % 5 == 0 and Tools.get_player().sanity > 30 and is_in_fog == true:
		Tools.get_player().sanity -= 10
	
	if is_escaping == true and Door_expe.disabled == true:
		Door_expe.disabled = false
	
	check_radio_conditions()

func find_and_remove(current: Node, depth: int):
	for child in current.get_children():
		var next_depth := depth + 1
		
		if child is MeshInstance3D and depth == 2:
			var is_deleted := randi_range(1,5)
			if is_deleted == 1 and child.visible == true:
				child.visible = false
				("Just deleted "+child.name+" !!!!!!!!!")
				return
		
		if child.get_child_count() > 0 and next_depth <= 2: #Creuse max depth 2
			find_and_remove(child, next_depth)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		if is_in_fog != true:
			is_in_fog = true
		(is_in_fog)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		if is_in_fog != false:
			is_in_fog = false
		(is_in_fog)
	

func exe_radio_msg(fp, text, duration, color, sender, cooldown):
	Tools.set_radio_sound(1,load(fp) as AudioStream)
	if cooldown == 0:
		Tools.radio_text(text,duration,color)
	elif cooldown != 0:
		Tools.radio_text(text, cooldown - 1, color)
	Tools.add_journal("Escape?", color)
	if cooldown != 0:
		gouv_time = time_elapsed + cooldown

func check_radio_conditions():
	var _fm = Radio.getFrequency()
	
	var eventjournal = get_tree().get_first_node_in_group("eventjournal")
	
	if ones == true and _fm > 0 and _fm < 4:
		if time_elapsed > gouv_time and msg_status == 0:
			exe_radio_msg(".","This is an official government message.",5,Tools.color_gov,"gouv",6)
			msg_status += 1
			Tools.event_journal_ok(1, false)
		if time_elapsed > gouv_time and msg_status == 1:
			exe_radio_msg(".","The districts’ evacuation is still ongoing.",5,Tools.color_gov,"gouv",6)
			msg_status += 1
			Tools.event_journal_ok(2, false)
		if time_elapsed > gouv_time and msg_status == 2:
			exe_radio_msg(".","Road Quarter will be cleared next. Local inhabitants, please ready yourself for our arrival.",9,Tools.color_gov,"gouv",10)
			msg_status += 1
			Tools.event_journal_ok(3, !eventjournal.get_child(3).visible)
		if time_elapsed > gouv_time and msg_status <= 3:
			exe_radio_msg(".","We thank you for your cooperation.",5,Tools.color_gov,"gouv",6)
			msg_status = 0
			Tools.event_journal_ok(4, false)
