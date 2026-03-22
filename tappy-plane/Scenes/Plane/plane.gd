extends CharacterBody2D

class_name Tappy
#signal on_plane_died

'''
the plane only need to detect the barrier so that's why we set collision mask to 1
'''

var gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var is_jump: bool = false
const JUMP_POWER: float = -350.0
@onready var plane_sprite: AnimatedSprite2D = $PlaneSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var engine_sound: AudioStreamPlayer = $engine_sound




# if we have _input then _unhandled_input will never be handled since the input has already been
# handled in _input
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("plane_jump"):
		#get_viewport().set_input_as_handled()


# will be called aevery process frame when input is available
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("plane_jump"):
		is_jump = true
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func die() -> void:
	#plane_sprite.stop()
	#set_physics_process(false)
	#on_plane_died.emit()
	SignalHub.emit_on_plane_died()
	get_tree().paused = true
	engine_sound.stop()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#velocity.x = 100.0
	engine_sound.play()
	velocity.y += gravity * delta # accelerating effect
	
	
	# we don't do Input.is_action_just_pressed() here directly because
	# physics_process poll at a constant frame rate (60) so our input might not be
	# detected in some cases. We can do separate function like this or check input in _process
	if is_jump:
		velocity.y = JUMP_POWER
		is_jump = false
		animation_player.play("thrust")
	#print(velocity.y)
	
	if is_on_floor():
		#print("on floor")
		die()
	
	move_and_slide()
