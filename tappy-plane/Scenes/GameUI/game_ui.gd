extends Control

class_name game_ui
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("click"):
		#print(event)
@onready var gameover_label: Label = $MarginContainer/gameover_label
@onready var pressspace_label: Label = $MarginContainer/pressspace_label
@onready var score_label: Label = $MarginContainer/score_label

@onready var score_sound: AudioStreamPlayer2D = $score_sound
@onready var gameover_sound: AudioStreamPlayer = $gameover_sound
@onready var timer: Timer = $Timer



var score: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()
	if Input.is_action_pressed("plane_jump") and pressspace_label.visible:
		print("space pressed show")
		GameManager.load_main_scene()


func _ready() -> void:
	gameover_label.hide()
	pressspace_label.hide()
	SignalHub.on_plane_died.connect(show_gameover)
	SignalHub.on_plane_scored.connect(show_score)

func show_gameover() -> void:
	gameover_label.show()
	gameover_sound.play()
	
	# set the high score (setter automatically works)
	ScoreManager.high_score = score
	
	timer.start()
	
	
func show_score() -> void:
	print("PLANE GOT SCORE!")
	score += 1
	print(score)
	score_sound.play()
	score_label.text = "%03d" % [score]


func _on_timer_timeout() -> void:
	gameover_label.hide()
	pressspace_label.show()
