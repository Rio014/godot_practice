extends TextureButton

@export var level_setting: LevelSetting


@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(level_setting) # we already overwrite this func in LevelSetting resource


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
