extends Node2D

const PLAYER_BULLET = preload("res://Scenes/Bullets/PlayerBullet/PlayerBullet.tscn")
const ENEMY_BULLET = preload("res://Scenes/Bullets/EnemyBullet/EnemyBullet.tscn")
const SHOOTER = preload("res://Scenes/Shooter/Shooter.tscn")

@onready var player: Player = $Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		#var new_bullet: Area2D = ENEMY_BULLET.instantiate()
		#player.add_child(new_bullet)
		pass
