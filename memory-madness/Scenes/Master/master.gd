extends Control


@onready var main: Control = $Main
@onready var game: Control = $Game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connected the signal
	SignalHub.on_level_selected.connect(on_level_selected)
	SignalHub.on_game_exit_pressed.connect(show_game)
	
	show_game(false)

func on_level_selected(level_setting: LevelSetting) -> void:
	# need this when we exit before the game finish and get back in
	# in some cases, the SelectionEnabled is not yet enable to true for the new game
	Scorer.SelectionEnabled = true 
	
	show_game(true)
	
func show_game(is_show: bool) -> void:
	game.visible = is_show
	main.visible = !is_show
