extends Node

#"user://tappyscore.tres" in normal format
#"user://tappyscore.res" in binary format
const SCORES_PATH: String = "user://tappyscore.res"




var high_score: int = 0:
	# getter
	get:
		return high_score
	set(value):
		if value > high_score:
			high_score = value
			save_high_score()

func _ready() -> void:
	load_high_score()

func save_high_score() -> void:
	var high_score_resource: HighScoreResource = HighScoreResource.new()
	high_score_resource.high_score = high_score
	ResourceSaver.save(high_score_resource, SCORES_PATH)


func load_high_score() -> void:
	# first we check whether the file we have exist or not
	if ResourceLoader.exists(SCORES_PATH):
		# if exists, then we load
		var high_score_resource: HighScoreResource = ResourceLoader.load(SCORES_PATH)
		if high_score_resource: # if load successfully
			high_score = high_score_resource.high_score 
		
