extends Area2D

@onready var splash_sound: AudioStreamPlayer2D = $SplashSound


func _on_body_entered(body: Node2D) -> void:
	if body is Animal:
		splash_sound.global_position = body.global_position # if the body is far away then less sound we hear
		splash_sound.play()
		body.die()
