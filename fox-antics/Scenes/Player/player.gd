extends CharacterBody2D

class_name Player

const GRAVITY: float = 690.0
const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 120.0

@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	player_move()
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y += JUMP_SPEED # not multiply delta since move_and_slide() already handled that
		

func player_move() -> void:
	var player_dir: float = Input.get_axis("left", "right")
	if !is_equal_approx(velocity.x, 0.0): # only flip when we move
		sprite_2d.flip_h = velocity.x < 0 # flip h if negative
	velocity.x = player_dir * RUN_SPEED 
