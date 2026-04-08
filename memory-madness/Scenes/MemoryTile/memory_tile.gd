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
	if Scorer.SelectionEnabled:
		reveal(true)
	SignalHub.on_tile_selected.emit(self)
	
func matches_other_tile(other_tile: MemoryTile) -> bool:
	if self.item_image.texture == other_tile.item_image.texture:
		return true
	else: 
		return false
		
func kill_on_pair() -> void:
	disabled = true # disable the tile so that it can't be clicked
	modulate = Color.TRANSPARENT
	
	
	
	
	
