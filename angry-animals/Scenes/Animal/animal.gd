extends RigidBody2D

class_name Animal

@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow

var _start: Vector2 = Vector2.ZERO # where animal start
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO

var _is_dragging: bool = false
const DRAG_LIM_MAX: Vector2 = Vector2(0,60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60,0)
const IMPULSE_MULT: float = 25.0
const IMPULSE_MAX: float = 2000.0 # we get this number from calculate_impulse().length()
var _arrow_scale_x: float = 0.0

# sound
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start = position
	arrow.hide()
	_arrow_scale_x = arrow.scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = "freeze: %s\ncontact count: %s\nsleep: %s\nanimal start: %s\ndrag start: %s\nis_drag: %s\ndragged_vector: %s\nimpulse: %s" % [
		freeze, get_contact_count(), sleeping, _start, _drag_start, _is_dragging, _dragged_vector, calculate_impulse()
		]
	#arrow.look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	if _is_dragging:
		handle_dragging()

		

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag") and _is_dragging:
		# defer the call of the function until idle time at the end of current frame
		# where there is a guarantee that there will be no physics calculation going on
		# that could potentially create a conflict
		call_deferred("start_release")

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#print(event)
	#print(_is_dragging)
	if event.is_action_pressed("drag"):
		# we can only drag once per click, so we disconnect (kinda like one shot)
		input_event.disconnect(_on_input_event)
		#print(input_event.get_connections())
		start_dragging()
	
	
func start_dragging() -> void:
	arrow.show()
	_is_dragging = true
	_drag_start = get_global_mouse_position()

func handle_dragging() -> void:
	var new_dragged_vector: Vector2 = get_global_mouse_position() - _drag_start
	new_dragged_vector = new_dragged_vector.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)
	
	var diff: Vector2 = new_dragged_vector - _dragged_vector # new drag - current drag to see if we move or not
	if diff.length() > 0 and !stretch_sound.playing:
		# means we drag since last frame
		stretch_sound.play()
		
	
	# update dragged vector
	scale_arrow() # rotate arrow and scale it
	_dragged_vector = new_dragged_vector
	position = _dragged_vector + _start
	

func calculate_impulse() -> Vector2:
	return (_dragged_vector * IMPULSE_MULT) * -1

func start_release() -> void:
	arrow.hide()
	_is_dragging = false
	freeze = false
	
	apply_central_impulse(calculate_impulse())
	launch_sound.play()
	
	# send attempt made signal
	SignalHub._emit_attempt_made()
	


func scale_arrow() -> void:
	# linear interpolate how far we are from impulse max in a scale of [0,1]
	var percent: float = clamp(calculate_impulse().length()/ IMPULSE_MAX, 0.0, 1.0)
	#print(percent)
	arrow.scale.x = lerpf(_arrow_scale_x, _arrow_scale_x * 2, percent)
	#var temp = _dragged_vector * -1
	#arrow.rotation = atan2(temp.y, temp.x)
	#arrow.rotation = (atan2(_dragged_vector.y, _dragged_vector.x))
	#arrow.rotation = _dragged_vector.angle()
	arrow.rotation = (_start - position).angle()
	#print(arrow.rotation)


func die() -> void:
	SignalHub._emit_animal_die()
	queue_free()


func _on_body_entered(body: Node) -> void:
	if !kick_sound.playing:
		kick_sound.play()
		SignalHub.animal_land_on_cup.emit()


func _on_sleeping_state_changed() -> void:
	if sleeping:
		# get the colliding body we are in contact with
		for body in get_colliding_bodies():
			if body is Cup: 
				body.disappear()
		die()
