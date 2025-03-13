extends Sprite3D

func _on_texture_changed():    
	var timer = Timer.new()
	timer.wait_time = 4  
	timer.one_shot = true  
	timer.timeout.connect(_on_timer_timeout) 
	add_child(timer)  
	timer.start() 

func _on_timer_timeout():
	if get_texture().load_path != "res://Sprite/sancheck_nothing.png" :
		set_texture(load("res://Sprite/sancheck_nothing.png") as Texture2D)
