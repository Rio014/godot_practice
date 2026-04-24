extends Resource

class_name HighScores

const   MAX_SCORES: int = 10 # we take top 10 highscores

@export var high_scores: Array[HighScore] = []

func _init() -> void:
	sort_scores()
	
func sort_scores() -> void:
	high_scores.sort_custom(func(a,b): return a.score > b.score) #lambda function

func get_scores_list() -> Array[HighScore]:
	return high_scores

func add_new_score(score: int):
	var new_score: HighScore = HighScore.new(score, FoxyUtils.formatted_dt())
	high_scores.append(new_score)
	sort_scores()
	
	if high_scores.size() > MAX_SCORES:
		high_scores.resize(MAX_SCORES) # the elements at the end are removed 
	
