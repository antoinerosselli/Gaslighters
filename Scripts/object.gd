extends Node3D

@export var item_name:String

@export_category("depot ?")
@export var depot:bool

@export_category("text ?")
@export var is_text:bool
@export var texts = []

@export_category("is a doors ?")
@export var door:bool
@export var rotation_amount = 1.5

@export_category("is an interruptor ?")
@export var is_on:bool
@export var is_an_interruptor:bool
@export var lamp:Node3D
@export var custom_range:float

@export_category("is a note ?")
@export var is_note : bool
@export var note : PackedScene

@export_category("have an unique trait ?")
@export var script_trait:bool

func _ready():
	pass 
	
func interact():
	if is_text == true:
		var player = Tools.get_player()	
		player.dialogues = texts
	if depot == true and Tools.get_player().ptich.visible == true:
		Tools.sound_now(self,load("res://Music&Sound/sound/spray-36842.mp3") as AudioStream)
		queue_free()
	if door == true:
		Tools.sound_now(self, load("res://Music&Sound/sound/door_sound.mp3") as AudioStream)
		transform.basis = Basis(Vector3(0, 1, 0), rotation_amount) * transform.basis
		rotation_amount = -(rotation_amount)
	if is_an_interruptor == true:
		Tools.sound_now(self, load("res://Music&Sound/sound/interrupteur_sound.mp3") as AudioStream)
		is_on = !is_on
		if UniqueTrait.elec == true :
			if is_on == true:
				var ligth = lamp.get_node("OmniLight3D")
				ligth.omni_range = custom_range
			elif  is_on == false:
				var ligth = lamp.get_node("OmniLight3D")
				ligth.omni_range = 0.0
	if is_note == true:
		Tools.notespawn(note)
	if script_trait == true:
		UniqueTrait.unique(item_name)
