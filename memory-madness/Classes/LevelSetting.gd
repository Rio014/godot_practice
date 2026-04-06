extends Resource

class_name LevelSetting

@export var row: int = 2
@export var col: int = 2


var total_tiles: int:
	get: return row * col 
	
var target_pairs: int:
	get: return total_tiles / 2

func _to_string() -> String:
	return "%dx%d" % [row, col]
