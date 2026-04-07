extends Node

signal on_level_selected(level_setting: LevelSetting)
signal on_game_exit_pressed
signal on_tile_selected(tile: MemoryTile)

func emit_on_level_selected(level_setting: LevelSetting) -> void:
	on_level_selected.emit(level_setting)

func emit_on_game_exit_pressed(is_show_game: bool) -> void:
	on_game_exit_pressed.emit(is_show_game)

func emit_on_tile_selected(tile: MemoryTile) -> void:
	on_tile_selected.emit(tile)
