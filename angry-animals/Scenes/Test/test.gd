extends Node


func restart() -> Error:
	var err = get_tree().reload_current_scene()
	return err
		
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		restart()
	if Input.is_action_just_pressed("ui_down"):
		print(get_children())
