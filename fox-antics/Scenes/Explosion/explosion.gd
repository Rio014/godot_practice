extends AnimatedSprite2D

class_name Explosion

@onready var explode_sound: AudioStreamPlayer2D = $ExplodeSound

func _ready() -> void:
	explode_sound.play()

func _on_animation_finished() -> void:
	queue_free()
