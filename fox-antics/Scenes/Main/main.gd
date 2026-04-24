extends Control


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		GameManager.load_next_level()
		
