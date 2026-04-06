extends Node

const ANIMAL = preload("res://Scenes/Animal/Animal.tscn")

@onready var marker_2d: Marker2D = $Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.animal_die.connect(spawn_animal)
	# first spawn 
	spawn_animal()



func spawn_animal() -> void:
	var new_animal: Animal = ANIMAL.instantiate()
	new_animal.position = marker_2d.position
	#add_child(new_animal) # there's an error in debugger
	call_deferred("add_child", new_animal)

#func spawn_animal() -> void:
	#print(get_children())
	#var found: bool = false
	#for i in get_children():
		#if i is Animal:
			#print("found animal")
			#found = true
	#if !found:
		#print("SPAWN ANIMAL")
		#var new_animal: Animal = ANIMAL.instantiate()
		#new_animal.position = marker_2d.position
		#add_child(new_animal)
