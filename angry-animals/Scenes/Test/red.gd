extends ColorRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input" %[name])
		
		# handled input
		#if name == "Green":
			#get_viewport().set_input_as_handled()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _unhandled_input" %[name])
		# handled input
		#if name == "Green":
			#get_viewport().set_input_as_handled()

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _gui_input" %[name])
	
