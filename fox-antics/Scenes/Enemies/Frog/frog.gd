extends EnemyBase
'''
1. detect player
2. flip sprite to face player
3. start timer with random range
4. apply jump logic
'''
@onready var jump_timer: Timer = $JumpTimer

var seen_player: bool = false
var can_jump: bool = false

const JUMP_VELOCITY: Vector2 = Vector2(100, -150)

func _physics_process(delta: float) -> void:
	# invoke what inside the parent function first
	super._physics_process(delta)
	
	add_frog_physics(delta)
	#apply_jump()
	

	move_and_slide()
	# after frog jump, if it landed on the floor, we have to set velocity x to 0, otherwise it just slides
	# also we set animation back to idle
	if is_on_floor():
		velocity.x = 0
		animated_sprite_2d.play("idle")
	

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	# this will be called everytime we see the frog (multiple "on screen" print), but we only want it to start once
	print("ON SCREEN") 
	
	# to prevent this, we have this if checking
	if seen_player == false:
		# set the flag amd start timer
		seen_player = true
		start_timer()

func start_timer() -> void:
	jump_timer.wait_time =  randf_range(2.0, 3.0)
	jump_timer.start()

func add_frog_physics(delta: float) -> void:
	# apply gravity
	velocity.y += _gravity * delta
	# turn the frog to face the player
	flip_frog()
	

func flip_frog() -> void:
	var player_x_dir: float = _player_ref.global_position.x
	
	# determine the dir the frog will be facing 
	if player_x_dir > global_position.x:
		# face left
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false


func _on_timer_timeout() -> void:
	can_jump = true
	print("frog jump!!")
	apply_jump()


func apply_jump() ->  void:
	if !is_on_floor() or can_jump == false or seen_player == false:
		return # can't jump in this case
	
	if animated_sprite_2d.flip_h == true:
		velocity =  JUMP_VELOCITY
	else:
		velocity.x =  -JUMP_VELOCITY.x
		velocity.y =  JUMP_VELOCITY.y
	
	# apply animation
	animated_sprite_2d.play("jump")	
		
	can_jump = false 
	start_timer()
	
