extends Label3D

func _process(_delta: float) -> void:
	if name == "Label3dRadio1": # LE NOM EST IMPORTANT
		text = Radio.getDisplay(1)
	if name == "Label3dRadio2": # PAREIL ICI
		text = Radio.getDisplay(2)
