extends Area2D

@export var points: int = 2

@onready var fruits_animation: AnimatedSprite2D = $FruitsAnimation
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fruit_list: Array[String] = []
	for each_anim in fruits_animation.sprite_frames.get_animation_names():
		fruit_list.append(each_anim)
	#print(fruit_list)
	
	# pick random fruits from the list
	fruits_animation.animation = fruit_list.pick_random()
	fruits_animation.play()
	
	

'''
note: if we just do pickup_sound.play() here, player can abuse this by gaining a lot of score before
the fruit despawn, so to prevent this, we hide fruits as soon as player enter and disable the collision
'''
func _on_area_entered(area: Area2D) -> void:
	#  increasing score
	SignalHub.emit_on_increase_score(points)
	hide()
	#print("area enterrrr")
	set_deferred("monitoring", false)
	pickup_sound.play()
	


func _on_pickup_sound_finished() -> void:
	queue_free()
