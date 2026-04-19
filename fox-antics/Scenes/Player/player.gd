extends CharacterBody2D

class_name Player

@export var fell_off_y: float = 800.0

const GRAVITY: float = 690.0
const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 120.0
const MAX_FALL_VELOCITY: float = 350.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel


@onready var shooter: Shooter = $Shooter
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound



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
		jump_sound.play()
		
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
