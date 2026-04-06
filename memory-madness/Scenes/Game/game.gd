extends Control

const MEMORY_TILE = preload("res://Scenes/MemoryTile/MemoryTile.tscn")

@onready var grid_container: GridContainer = $HBoxContainer/GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connected to signal
	SignalHub.on_level_selected.connect(on_level_selected)
	

func on_level_selected(level_setting: LevelSetting) -> void:
	print("level selected: %s" % [str(level_setting)])
	create_tile(level_setting)

func create_tile(level_setting: LevelSetting) -> void:
	#  first we set the number of columns (depends on each level col)
	grid_container.columns = level_setting.col
	for tile in range(level_setting.total_tiles):
		var new_tile: MemoryTile = MEMORY_TILE.instantiate()
		grid_container.add_child(new_tile)
		


func _on_exit_button_pressed() -> void:
	# remove each children of the grid container (in this game, we do not change scene, we just hide and show)
	for tile in grid_container.get_children():
		tile.queue_free()
	
	SignalHub.emit_on_game_exit_pressed(false)
