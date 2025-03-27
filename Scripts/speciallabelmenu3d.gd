extends Label3D

func _ready():
	var timer = Timer.new()
	timer.wait_time = 0.2  
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout) 
	add_child(timer)
	timer.start()

func _on_Timer_timeout():
	var minutes = randi() % 100
	var seconds = randi() % 100 
	var time_string = "%02d:%02d" % [minutes, seconds]
	text = time_string
