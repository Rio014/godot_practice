extends Node

signal on_plane_died
signal on_plane_scored

func emit_on_plane_died() -> void:
	on_plane_died.emit()

func emit_on_plane_scored() -> void:
	on_plane_scored.emit()
