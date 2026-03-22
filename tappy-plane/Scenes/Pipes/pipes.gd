extends Node2D

class_name Pipes

var pipe_scroll_speed: float = -120
@onready var laser: Area2D = $Laser


#signal plane_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)

func on_plane_died() -> void:
	# when the plane dies, we want to disconnect the laser exited (so that the score count will be stopped)
	# if we don't have this line, if the plane dies inside laser, then +1 score is counted 
	disconnect_laser()
	
func disconnect_laser() -> void:
	if laser.body_entered.is_connected(_on_laser_body_exited):
		laser.body_exited.disconnect(_on_laser_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += pipe_scroll_speed * delta


func _on_screen_notifier_screen_exited() -> void:
	#print("EXIT")
	queue_free()


func _on_life_timer_timeout() -> void:
	queue_free() # this is kind of a safety protection in case the screen notifier had bug
	# each pipe will be removed regardless in 60 sec


# use body entered instead of area 2d because the plane is character body 2d type
func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()
		#print("_on_body_entered: ", body.name)


func _on_laser_body_exited(body: Node2D) -> void:
	if body is Tappy:
		#print("Plane entered laser!")
		#plane_score.emit()
		disconnect_laser()
		SignalHub.emit_on_plane_scored()
		
