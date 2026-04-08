extends Node

class_name Scorer

# we use static here because we want this var to exist in a class level
# not an individual node (that we have to instantiate before use it)
static var SelectionEnabled: bool = true
var selected_tiles: Array[MemoryTile] = []
var pairs_made: int = 0 
var target_pairs: int = 99

var num_moves_made: int = 0

@onready var reveal_timer: Timer = $RevealTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_tile_selected.connect(on_tile_selected)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)
	
	
func clear_new_game() -> void:
	# reset score to 0 everytime we start the game
	pairs_made = 0
	num_moves_made = 0
	SelectionEnabled = true
	selected_tiles.clear() 

func on_tile_selected(tile: MemoryTile) -> void:
	if tile in selected_tiles:
		return
	if !SelectionEnabled:
		return
	selected_tiles.append(tile)	
	process_pair()
	#print("selected tiles: %s" % [selected_tiles])


func process_pair() -> void:
	if selected_tiles.size() != 2:
		return

	SelectionEnabled = false
	reveal_timer.start()
	check_for_pair()

func check_for_pair() -> void:
	num_moves_made += 1
	if selected_tiles[0].matches_other_tile(selected_tiles[1]):
		selected_tiles[0].kill_on_pair()
		selected_tiles[1].kill_on_pair()
		pairs_made += 1

func get_pair_str() -> String:
	return "%d/%d" % [pairs_made, target_pairs]


func _on_reveal_timer_timeout() -> void:
	# hide the selected tiles
	print("THIS IS STILL BEING CALLED!")
	for tile in selected_tiles:
		if is_instance_valid(tile): # need this in case we still have race condition
			tile.reveal(false)
	
	# clear tile selection and reenable the selection
	SelectionEnabled = true
	selected_tiles.clear()  # clear the array
	
	
	
	
func on_game_exit_pressed() -> void:
	# has to stop otherwise when the game "exit" all the tile will be queue_free before
	# the selected_tile is cleared by _on_reveal_timer_timeout() (it will clear nothing in this case)
	reveal_timer.stop() 
	# print("WE ARE HEREEE!") # never called currently which means timer timeout happens before this!
	selected_tiles.clear()  # clear the array
