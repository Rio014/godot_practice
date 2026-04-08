extends Node

signal on_level_selected(level_setting: LevelSetting)
signal on_game_exit_pressed(is_show_game: bool)
signal on_tile_selected(tile: MemoryTile)
signal on_game_over(num_moves_made: int)

func emit_on_level_selected(level_setting: LevelSetting) -> void:
	on_level_selected.emit(level_setting)

func emit_on_game_exit_pressed(is_show_game: bool) -> void:
	on_game_exit_pressed.emit(is_show_game)

func emit_on_tile_selected(tile: MemoryTile) -> void:
	on_tile_selected.emit(tile)
	
func emit_on_game_over(num_moves_made: int) -> void:
	on_game_over.emit(num_moves_made)
