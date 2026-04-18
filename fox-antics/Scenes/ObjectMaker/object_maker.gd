extends Node2D


const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: preload("res://Scenes/Bullets/PlayerBullet/PlayerBullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY: preload("res://Scenes/Bullets/EnemyBullet/EnemyBullet.tscn"),
	Constants.ObjectType.EXPLOSION: preload("res://Scenes/Explosion/Explosion.tscn"),
	Constants.ObjectType.PICKUP: preload("res://Scenes/FruitPickup/FruitPickup.tscn")
}

func _enter_tree() -> void:
	SignalHub._on_create_bullet.connect(create_bullet)
	SignalHub._on_create_object.connect(create_object)
	

func create_bullet(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(obj_type):
		return
	
	var new_bullet: BulletBase = OBJECT_SCENES[obj_type].instantiate()
	new_bullet.setup(pos, dir, speed)
	call_deferred("add_child", new_bullet) # in case this happen when the engine is calculating something

func create_object(pos: Vector2, obj_type: Constants.ObjectType):
	#if obj_type == Constants.ObjectType.EXPLOSION:
		#print("EXPLODE")
		#var new_explosion: Explosion = OBJECT_SCENES[obj_type].instantiate()
		#new_explosion.global_position = pos
		## new_explosion.play() already set auto-play
		#call_deferred("add_child", new_explosion)
	
	# make this a generic function instead
	# first check the obj_type
	if !OBJECT_SCENES.has(obj_type):
		print("no given obj type")
		return
	
	var new_obj: Node2D = OBJECT_SCENES[obj_type].instantiate()
	new_obj.global_position = pos
	call_deferred("add_child", new_obj)
		
