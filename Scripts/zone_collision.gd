extends Area3D

@export var one_shot:bool = false
@export var is_text:bool = false
@export var texts = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):
	if self.visible == true :
		if is_text == true : 
			body.dialogues = texts
		if one_shot == true :
			queue_free()
