extends Label

func _process(delta):
	if get_tree().get_first_node_in_group("notenote") != null:
		self.visible = false
