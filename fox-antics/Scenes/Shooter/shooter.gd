extends Node2D

class_name Shooter

@export var speed: float
@export var bullet_key: Constants.ObjectType
@export var shoot_delay: float = 0.7

var _can_shoot: bool = false

@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_sound: AudioStreamPlayer2D = $ShootSound




func  _ready() -> void:
	shoot_timer.wait_time = shoot_delay
	_can_shoot = true


func shoot(direction: Vector2) -> void:
	if _can_shoot:
		# create a bullet
		SignalHub.emit_on_create_bullet(global_position, direction, speed, bullet_key)
		_can_shoot = false
		#print("%s shooter shot direction: %s" % [get_parent(), direction])
		# start timer
		shoot_timer.start()
	else:
		return


func _on_shoot_timer_timeout() -> void:
	print("shooter timer timeout")
	_can_shoot = true
