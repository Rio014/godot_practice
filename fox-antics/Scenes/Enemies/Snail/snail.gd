extends EnemyBase # we extends this means that we will have all the features/functionality we have in EnemyBase script

@onready var ray_cast_2d: RayCast2D = $RayCast2D


func _physics_process(delta: float) -> void:
	# invoke what inside the parent function first
	super._physics_process(delta)
	
	add_snail_physics(delta)
	flip_snail()

func add_snail_physics(delta: float) -> void:
	# add gravity
	velocity.y += _gravity * delta # gravity is from the parent scene
	
	# snail movement (by default, snail sprite faces left direction)
	if animated_sprite_2d.flip_h == true:
		velocity.x = speed
	else:
		velocity.x = speed * -1
	move_and_slide()
	
		
func flip_snail() -> void:
	# we want to flip snail if it's  either 1. hit the wall 2. the ray cast does not detect the floor collide
	if is_on_wall() or !ray_cast_2d.is_colliding():
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h	
		ray_cast_2d.position.x = -ray_cast_2d.position.x # flip ray cast as well
