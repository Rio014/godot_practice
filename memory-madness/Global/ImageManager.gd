extends Node

const TILE_IMAGES: TileImagesHolder = preload("res://Resources/TileImages.tres")
const FRAME_IMAGES: Array[Texture2D] = [
	preload("res://Assets/frames/green_frame.png"),
	preload("res://Assets/frames/red_frame.png"),
	preload("res://Assets/frames/yellow_frame.png"),
	preload("res://Assets/frames/blue_frame.png")
]

func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()

func get_random_item_image() -> Texture2D:
	#return TILE_IMAGES.tile_images[randi() % (TILE_IMAGES.tile_images.size())]
	return TILE_IMAGES.tile_images.pick_random()

func shuffle_images() -> void:
	TILE_IMAGES.tile_images.shuffle()

func get_image_at_index(index: int) -> Texture2D:
	if index > TILE_IMAGES.tile_images.size() or index < 0:
		print("[ERROR] tile images index is out of bound")
	return TILE_IMAGES.tile_images[index]
