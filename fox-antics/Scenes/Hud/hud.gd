extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel

var current_score: int = 0

func _enter_tree() -> void:
	SignalHub._on_increase_score.connect(update_score)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		GameManager.load_main()


func update_score(score: int) -> void:
	current_score += score
	score_label.text  = "%04d" % [current_score]
