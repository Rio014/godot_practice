extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_item_image()
	run_me()
	
func set_random_item_image() -> void:
	texture = ImageManager.get_random_item_image()	

func get_random_spin_time() -> float:
	return randf_range(1.0, 2.0)

func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))

func run_me() -> void:
	var tween: Tween = create_tween()
	tween.set_loops() # run infinitely
	tween.tween_property(self, "scale", Vector2(0.05, 0.05), 1.0)
	tween.tween_callback(set_random_item_image)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1.0)
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	# set random pause to let things catch up behind the scene
	tween.tween_interval(0.05)
	tween.tween_callback(run_me)
	
	
	
	
	
	
	
	
