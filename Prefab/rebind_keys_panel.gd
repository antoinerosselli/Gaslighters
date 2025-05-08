extends Panel
@onready var MF = $MoveForward/MFedit
@onready var MB = $MoveBackward/MBedit
@onready var ML = $MoveLeft/MLedit
@onready var MR = $MoveRight/MRedit
@onready var AI = $ActionInteract/AIedit

func _ready():
	var input_map = Data.get_inputs()
	
	MF.text = input_map["up"]
	MB.text = input_map["down"]
	ML.text = input_map["left"]
	MR.text = input_map["right"]
	AI.text = input_map["interact"]
	
	MF.text = key_finder(InputMap.action_get_events("up"))
	MB.text = key_finder(InputMap.action_get_events("down"))
	ML.text = key_finder(InputMap.action_get_events("left"))
	MR.text = key_finder(InputMap.action_get_events("right"))
	AI.text = key_finder(InputMap.action_get_events("interact"))

func key_finder(action):
	var key_action = action[0]
	var key_string = OS.get_keycode_string(key_action.keycode)
	return str(key_string)

func key_adder(text):
	var key_string = text.strip_edges().to_upper()
	if key_string.length() != 1 or not key_string.is_valid_identifier() or not key_string.is_subsequence_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
		print("Touche invalide ou non prise en charge :", key_string)
		return null

	var keycode = OS.find_keycode_from_string(key_string)
	if keycode != 0:
		var event := InputEventKey.new()
		event.keycode = keycode
		event.pressed = true
		return event
	else:
		print("Touche invalide :", key_string)
		return null


func _on_close_pressed():
	self.visible = false

func _on_apply_pressed():
	if MF.text == "" : MF.text = "W"
	if MB.text == "" : MB.text = "S"
	if ML.text == "" : ML.text = "Q"
	if MR.text == "" : MR.text = "D"
	if AI.text == "" : AI.text = "E"
	
	InputMap.action_erase_events("up")
	InputMap.action_add_event("up", key_adder(MF.text))
	
	InputMap.action_erase_events("down")
	InputMap.action_add_event("down", key_adder(MB.text))
	
	InputMap.action_erase_events("left")
	InputMap.action_add_event("left", key_adder(ML.text))
	
	InputMap.action_erase_events("right")
	InputMap.action_add_event("right", key_adder(MR.text))
	
	InputMap.action_erase_events("interact")
	InputMap.action_add_event("interact", key_adder(AI.text))
	
	var input_map: Dictionary = {
  	"up": MF.text,
  	"down": MB.text,
	"left" : ML.text,
	"right": MR.text,
	"interact": AI.text,
	}

	Data.set_inputs(input_map)
	Tools.change_lesinputs("player")

func _on_m_fedit_text_changed(new_text):
	if new_text.length() > 0:
		var char = new_text[0].to_upper()
		if char.is_subsequence_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
			MF.text = char  # Force une seule lettre majuscule
		else:
			MF.text = "W"  # Invalide → on efface

func _on_m_bedit_text_changed(new_text):
	if new_text.length() > 0:
		var char = new_text[0].to_upper()
		if char.is_subsequence_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
			MB.text = char  # Force une seule lettre majuscule
		else:
			MB.text = "S"  # Invalide → on efface


func _on_m_ledit_text_changed(new_text):
	if new_text.length() > 0:
		var char = new_text[0].to_upper()
		if char.is_subsequence_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
			ML.text = char  # Force une seule lettre majuscule
		else:
			ML.text = "A"  # Invalide → on efface


func _on_m_redit_text_changed(new_text):
	if new_text.length() > 0:
		var char = new_text[0].to_upper()
		if char.is_subsequence_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
			MR.text = char  # Force une seule lettre majuscule
		else:
			MR.text = "D"  # Invalide → on efface

func _on_a_iedit_text_changed(new_text):
	if new_text.length() > 0:
		var char = new_text[0].to_upper()
		if char.is_subsequence_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
			AI.text = char  # Force une seule lettre majuscule
		else:
			AI.text = "E"  # Invalide → on efface
