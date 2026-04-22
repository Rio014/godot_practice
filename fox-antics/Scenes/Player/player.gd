extends CharacterBody2D

class_name Player

@export var fell_off_y: float = 800.0

const GRAVITY: float = 690.0
const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 120.0
const MAX_FALL_VELOCITY: float = 350.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130.0) 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel


@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound

@onready var remain_hurt_timer: Timer = $RemainHurtTimer

# audio stream
const JUMP = preload("res://assets/sound/jump.wav")
const DAMAGE = preload("res://assets/sound/damage.wav")


var is_hurt: bool = false
var is_invincible: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _enter_tree() -> void:
	# add player to group "Player"
	add_to_group(Constants.PLAYER_GROUP)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	player_move()
	move_and_slide()
	fallen_off()
	
	debug_show()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y += JUMP_SPEED # not multiply delta since move_and_slide() already handled that
		#sound.play()
		play_effect(JUMP)
		
	# test shooting (delete later)
	if  event.is_action_pressed("shoot"):
		var dir: Vector2
		if sprite_2d.flip_h == true:
			dir = Vector2.LEFT
		else:
			dir = Vector2.RIGHT
		shooter.shoot(dir)
		#print("SHOOT FROM PLAYER")
		

func player_move() -> void:
	if is_hurt:
		return # no movement if player is hurt
	var player_dir: float = Input.get_axis("left", "right")
	if !is_equal_approx(velocity.x, 0.0): # only flip when we move
		sprite_2d.flip_h = velocity.x < 0 # flip h if negative
	velocity.x = player_dir * RUN_SPEED 
	
	# clamp fall velocity
	velocity.y =clampf(velocity.y, JUMP_SPEED, MAX_FALL_VELOCITY)

func fallen_off() -> void:
	if global_position.y > fell_off_y:
		queue_free()
	


func debug_show() -> void:
	var debug_str: String
	debug_str = "Floor: %s\nvelocity:%s\nglobal_pos:%s" % [is_on_floor(), velocity, global_position]
	debug_label.text = debug_str

func go_invincible() -> void:
	is_invincible = true
	
	# flash for short duration
	var tween: Tween = create_tween()
	for i in range(3): # flashing a total of 3 seconds
		tween.tween_property(sprite_2d, "modulate", Color("ffffff", 0.0), 0.5) # transparent
		tween.tween_property(sprite_2d, "modulate", Color("ffffff", 1.0), 0.5)
	tween.tween_property(self, "is_invincible", false, 0)

func apply_hit() -> void:
	if is_invincible:
		return
	
	go_invincible()
	apply_hurt_jump()
	
func apply_hurt_jump() -> void:
	is_hurt = true
	remain_hurt_timer.start()
	velocity = HURT_JUMP_VELOCITY
	play_effect(DAMAGE)
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	# we are setting hurt jump velocity during the time we receive this signal during the frame
	# so we call deferred to avoid issue with the physics
	call_deferred("apply_hit")

	


func _on_remain_hurt_timer_timeout() -> void:
	is_hurt = false


# switch existing sound effect with the given effect
func play_effect(effect: AudioStream) -> void:
	sound.stop()
	sound.stream = effect
	sound.play()
	
