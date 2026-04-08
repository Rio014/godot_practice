extends PanelContainer

@onready var you_win_label: Label = $VBoxContainer/YouWinLabel
@onready var moves_label: Label = $VBoxContainer/MovesLabel

func _ready() -> void:
	SignalHub.on_game_over.connect(update_moves_label)

func update_moves_label(num_moves_made: int) -> void:
	moves_label.text = "Moves: %d" % [num_moves_made]
