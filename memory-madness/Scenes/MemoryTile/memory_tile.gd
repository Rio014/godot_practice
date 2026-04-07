extends TextureButton

class_name MemoryTile

@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage

func _ready() -> void:
	reveal(false)

func setup(image: Texture2D, frame: Texture2D) -> void:
	frame_image.texture = frame
	item_image.texture = image
	
	
func reveal(is_reveal: bool) -> void:
	frame_image.visible = is_reveal
	item_image.visible = is_reveal
	

func _on_pressed() -> void:
	reveal(true)
