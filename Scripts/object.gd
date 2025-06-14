extends Node3D

@export var item_name:String
@export var activate:bool = true

@export_category("Food ?")
@export var food:bool

@export_category("pickable ?")
@export var pickable:bool

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
	if depot == true:
		$AnimationPlayer.play("spawn")

func _process(_delta):
	if is_an_interruptor == true && UniqueTrait.elec == false:
		is_on = false

func interact():
	var player = Tools.get_player()
	if activate == true:
		if is_text == true:
			player.dialogues = texts
		if depot == true and Tools.get_player().ptich.visible == true:
			Data.add_spots()
			Tools.sound_now(self,load("res://Music&Sound/sound/spray-36842.mp3") as AudioStream)
			queue_free()
		if door == true:
			Data.add_door()
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
			Tools.sound_now(self, load("res://Music&Sound/sound/paperopen.mp3") as AudioStreamMP3)
			Tools.notespawn(note)
		if food == true:
			if player.sanity == 100:
				return
			player.sanity += 10
			if player.sanity > 100:
				player.sanity = 100
			Tools.sound_now(self,preload("res://Music&Sound/eat.mp3") as AudioStreamMP3)
		if script_trait == true:
			UniqueTrait.unique(item_name)
		if pickable == true:
			self.queue_free()
		
