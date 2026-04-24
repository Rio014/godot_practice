extends Control

const HIGH_SCORE_DISPLAY_V_BOX = preload("res://Scenes/HighScoreDisplay/HighScoreDisplayVBox.tscn")
@onready var grid_container: GridContainer = $MarginContainer/GridContainer


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		GameManager.load_next_level()
		
func _ready() -> void:
	set_scores()

func set_scores() -> void:
	# loop through the score lists we have
	for score: HighScore in GameManager.high_scores.get_scores_list():
		# instantiate new high score display object
		var new_high_score_display: HighScoreDisplayItem = HIGH_SCORE_DISPLAY_V_BOX.instantiate()
		new_high_score_display.setup(score)
		grid_container.add_child(new_high_score_display)
