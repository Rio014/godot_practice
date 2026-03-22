extends Node

const MAIN = preload("res://Scenes/Main/main.tscn")
const GAME = preload("res://Scenes/Game/game.tscn")
const SIMPLE_CHANGE = preload("res://Scenes/Changes/simple_change.tscn")
const COMPLEX_CHANGE = preload("res://Scenes/Changes/complex_change.tscn")

var next_scene: PackedScene
var cx: ComplexChange

func _ready() -> void:
	cx = COMPLEX_CHANGE.instantiate()
	add_child(cx)


func change_to_next() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)

# this function is used on complext scene
func start_transition(to_scene: PackedScene) -> void:
	next_scene = to_scene
	#print("current next scene: ", next_scene)
	cx.play_anim()



func load_main_scene() -> void:
	#get_tree().paused = false
	next_scene = MAIN
	#get_tree().change_scene_to_packed(SIMPLE_CHANGE)
	start_transition(next_scene)

func load_game_scene() -> void:
	next_scene = GAME
	#get_tree().change_scene_to_packed(SIMPLE_CHANGE)
	start_transition(next_scene)
