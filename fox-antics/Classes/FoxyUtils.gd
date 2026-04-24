#@tool 
class_name FoxyUtils
#extends EditorScript
# format date

static func formatted_dt() -> String:
	var date_time: Dictionary = Time.get_date_dict_from_system()
	# { "year": 2026, "month": 4, "day": 22, "weekday": 3 }
	
	return "%02d/%02d/%02d" % [date_time["day"], date_time["month"], date_time["year"]]
	
#func _run() -> void:
	#print(formatted_dt())
