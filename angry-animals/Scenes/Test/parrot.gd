extends Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input" %[name])
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _unhandled_input" %[name])
		
func _unhandled_key_input(event: InputEvent) -> void:
	
	print("%s _unhandled_key_input %s" %[name, event.as_text()])

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input_event" %[name])
