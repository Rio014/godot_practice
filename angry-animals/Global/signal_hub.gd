extends Node

signal animal_die
signal animal_land_on_cup
signal increase_score
signal on_attempt_made

func _emit_animal_die() -> void:
	animal_die.emit()
	
func _emit_animal_landing() -> void:
	animal_land_on_cup.emit()

func _emit_increase_score() -> void:
	# emit score when cup destroyed
	increase_score.emit()

func _emit_attempt_made() -> void:
	on_attempt_made.emit()
