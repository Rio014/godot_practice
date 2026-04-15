extends Node

signal _on_create_bullet(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType)
	
func emit_on_create_bullet(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	_on_create_bullet.emit(pos, dir, speed, obj_type)
