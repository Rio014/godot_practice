extends Control

const MEMORY_TILE = preload("res://Scenes/MemoryTile/MemoryTile.tscn")

@onready var grid_container: GridContainer = $HBoxContainer/GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connected to signal
	SignalHub.on_level_selected.connect(on_level_selected)
	
	
	

func on_level_selected(level_setting: LevelSetting) -> void:
	print("level selected: %s" % [str(level_setting)])
	
	# get images for the game
	var level_data_selector: LevelDataSelector = LevelDataSelector.new()
	var selected_images: Array[Texture2D] = level_data_selector.get_images_for_level(level_setting)
	var selected_frame: Texture2D = ImageManager.get_random_frame_image()
	
	create_tile(level_setting, selected_images, selected_frame)
		
		
	


func create_tile(level_setting: LevelSetting, selected_images: Array[Texture2D], selected_frame: Texture2D) -> void:
	#  first we set the number of columns (depends on each level col)
	grid_container.columns = level_setting.col
	for tile in range(level_setting.total_tiles):
		# create memory tile
		var new_tile: MemoryTile = MEMORY_TILE.instantiate()
		grid_container.add_child(new_tile) 
		
		# setup memory tile
		new_tile.setup(selected_images[tile], selected_frame)
		
		
		# if we put this here, we will get error because @onready var only populate after
		# add_child() is called, but we setup before add_child() (see memory_tile.gd @onready var)
		#grid_container.add_child(new_tile) 
		


func _on_exit_button_pressed() -> void:
	# remove each children of the grid container (in this game, we do not change scene, we just hide and show)
	for tile in grid_container.get_children():
		tile.queue_free()
	
	SignalHub.emit_on_game_exit_pressed(false)
