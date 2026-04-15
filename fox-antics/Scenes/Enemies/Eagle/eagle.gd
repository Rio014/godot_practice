extends EnemyBase

'''
note: raycast collide with area instead of body in this case because
we want it to detect player hitbox area of the player

eagle doesn't do anything until it sees player
once it sees player, it starts flying descend at a constant speed

when the timer times out, it's turning toward the player
start direction timer when eagle sees the player
'''

@export var fly_speed: Vector2 = Vector2(35, 15) # if player is on the left of eagle (-35, 15)
# why (35, 15) works? remember that downward is y positive, so (35, 15) is in quadrant 4 

@onready var direction_timer: Timer = $DirectionTimer
@onready var player_detect_ray_cast: RayCast2D = $PlayerDetectRayCast
@onready var shooter: Shooter = $Shooter


var _fly_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	velocity = _fly_direction # constantly update in set_fly_dir()
	#velocity.y += _gravity * delta
	move_and_slide()
	
	# shoot whenever raycast collide with player hitbox
	shoot()
	

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	direction_timer.start()
	eagle_fly_to_player()


func eagle_fly_to_player() -> void:
	# turn toward player dir
	flip_eagle()
	# set fly dir
	set_fly_dir()
	animated_sprite_2d.play("fly")


func set_fly_dir() -> void:
	# set a fly direction
	if animated_sprite_2d.flip_h == true: # eagle face right dir
		_fly_direction = fly_speed # Q4
	else:
		_fly_direction.x = -fly_speed.x
		_fly_direction.y = fly_speed.y # Q3

func flip_eagle() -> void:
	var player_x_dir: float = _player_ref.global_position.x
	# determine the dir the eagle will be facing
	if global_position.x <= player_x_dir:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false


func _on_direction_timer_timeout() -> void:
	eagle_fly_to_player()
	

func shoot() -> void:
	if player_detect_ray_cast.is_colliding():
		#print("eagle shoot")
		var dir: Vector2 = global_position.direction_to(_player_ref.global_position)
		shooter.shoot(dir)
