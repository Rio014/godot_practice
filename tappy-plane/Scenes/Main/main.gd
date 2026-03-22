extends Control

# load GAME everytime we asked to use it, not before (at compile time) like preload
#var GAME = load("res://Scenes/Game/game.tscn")


@onready var score_label: Label = $MarginContainer/score_label




func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("plane_jump"):
		GameManager.load_game_scene()

func _ready() -> void:
	get_tree().paused = false
	score_label.text = "%03d" % [ScoreManager.high_score]
	










## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
