extends Node

signal _on_create_bullet(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType)
signal _on_create_object(pos: Vector2, obj_type: Constants.ObjectType)

	
func emit_on_create_bullet(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	_on_create_bullet.emit(pos, dir, speed, obj_type)

func emit_on_create_object(pos: Vector2, obj_type: Constants.ObjectType):
	_on_create_object.emit(pos, obj_type)
