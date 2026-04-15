extends Node2D


const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: preload("res://Scenes/Bullets/PlayerBullet/PlayerBullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY: preload("res://Scenes/Bullets/EnemyBullet/EnemyBullet.tscn")
}

func _enter_tree() -> void:
	SignalHub._on_create_bullet.connect(create_bullet)
	

func create_bullet(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(obj_type):
		return
	
	var new_bullet: BulletBase = OBJECT_SCENES[obj_type].instantiate()
	new_bullet.setup(pos, dir, speed)
	call_deferred("add_child", new_bullet) # in case this happen when the engine is calculating something
