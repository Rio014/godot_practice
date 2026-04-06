extends Control

const MAIN = preload("res://Scenes/Main/main.tscn")


@onready var v_box_complete: VBoxContainer = $VBoxComplete
@onready var music: AudioStreamPlayer = $Music
@onready var attempt_num: Label = $MarginContainer/VBoxContainer/AttemptHBoxContainer/AttemptNum
@onready var level_num: Label = $MarginContainer/VBoxContainer/HBoxContainer/LevelNum

var total_cups: int = 0
var current_cups: int = 0
var score: int = 0
var attempt: int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	
	level_num.text = "%d" % [ScoreManager.level_selected]
	
	SignalHub.increase_score.connect(decrease_num_cup)
	SignalHub.on_attempt_made.connect(attempt_count)
	
	total_cups = get_tree().get_node_count_in_group(Cup.GROUP_NAME) 
	# get_tree().get_nodes_in_group(Cup.GROUP_NAME).size alternatively
	print("total cups: ",total_cups)
	current_cups = total_cups
	
	attempt_count() # do this in case we have random text in editor


func _process(delta: float) -> void:
	#print("current cup: %d\n current score: %d" % [current_cups, score])
	pass
	# we can't play music here cause this thing refresh every frame!
		## When there are no cups left, show the VbComplete
	#if current_cups == 0:
		#v_box_complete.show()
		#music.play()

	
func decrease_num_cup() -> void:
	current_cups -= 1
	score += 1

	# When there are no cups left (we complete the level), show the VbComplete
	if current_cups == 0:
		v_box_complete.show()
		music.play()
		
		# update the highscore
		ScoreManager.set_score_for_current_level(attempt)
		ScoreManager.save_scores_from_file()
		
		get_tree().paused = true
		
	

func attempt_count() -> void:
	attempt += 1
	attempt_num.text = "%d" % [attempt]	
	
	
	
	
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(MAIN)
