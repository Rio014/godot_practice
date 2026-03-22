extends Control

@onready var timer: Timer = $Timer

func _ready() -> void:
	#timer.start()
	
	# alternative method of not using timer
	await get_tree().create_timer(2.0).timeout
	GameManager.change_to_next()

#func _on_timer_timeout() -> void:
	#GameManager.change_to_next()
	
#func _process(_delta: float) -> void:
	#print("time leftt= ", timer.time_left)
