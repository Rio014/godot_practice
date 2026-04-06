extends Node


const SCORE_PATH = "user://animals_scores.res"

var level_selected: int = 1:
	get: return level_selected
	set (value): level_selected = value
	
var level_scores: LevelScoresResource = LevelScoresResource.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(LEVELSCORES.get_level_best(1))
	#set_score_for_current_level(11)
	#print(LEVELSCORES.get_level_best(1))
	load_scores_from_file()

func get_level_best(level: int) -> int:
	return level_scores.get_level_best(level)


func set_score_for_current_level(score: int) -> void:
	level_scores.try_update_best_score(level_selected, score)
	save_scores_from_file() 

# this function won't be running on first tries at all since we don't have the resource
# on the PATH yet (we will have one when we save it for the first time)
# you can delete animals_scores.res to see that "HEREEEE" won't be printed 
func load_scores_from_file() -> void:
	if ResourceLoader.exists(SCORE_PATH):
		# if resource already exists, we just loaded it
		print("HEREEEE") 
		level_scores = load(SCORE_PATH)

func save_scores_from_file() -> void:
	ResourceSaver.save(level_scores, SCORE_PATH)
	
