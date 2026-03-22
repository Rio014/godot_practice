extends Node

const PIPES = preload("res://Scenes/Pipes/pipes.tscn")



@onready var upper_spawn: Marker2D = $UpperSpawn # (530.0, 280.0)
@onready var lower_spawn: Marker2D = $LowerSpawn # (530.0, 550.0)
@onready var pipes_holder: Node = $PipesHolder







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func pipe_spawn() -> void:
	#print(lower_spawn.global_position)
	var rand_pos_y: float = randf_range(upper_spawn.position.y, lower_spawn.position.y)
	var spawn_pos: Vector2 = Vector2(upper_spawn.position.x, rand_pos_y)
	
	var new_pipe: Pipes = PIPES.instantiate()
	new_pipe.position = spawn_pos
	
	# connect signal to each pipe
	#new_pipe.plane_score.connect(_plane_score)
	
	pipes_holder.add_child(new_pipe)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	pipe_spawn()
	
#func _plane_score() -> void:
	#print("PLANE SCORE")
	
	
