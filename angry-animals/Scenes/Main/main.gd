extends Control

@onready var level_button_1: TextureButton = $HBoxContainer/LevelButton1
@onready var level_button_2: TextureButton = $HBoxContainer/LevelButton2
@onready var level_button_3: TextureButton = $HBoxContainer/LevelButton3



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().paused = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
