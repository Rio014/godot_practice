extends Area2D

@export var points: int = 2

@onready var fruits_animation: AnimatedSprite2D = $FruitsAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fruit_list: Array[String] = []
	for each_anim in fruits_animation.sprite_frames.get_animation_names():
		fruit_list.append(each_anim)
	#print(fruit_list)
	
	# pick random fruits from the list
	fruits_animation.animation = fruit_list.pick_random()
	fruits_animation.play()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
