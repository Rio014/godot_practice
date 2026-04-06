extends StaticBody2D

class_name Cup

@onready var vanish_sound: AudioStreamPlayer2D = $VanishSound
@onready var disappear_animation: AnimationPlayer = $DisappearAnimation


const GROUP_NAME: String = "Cup"

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SignalHub.animal_land_on_cup.connect(disappear)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func disappear() -> void:
	disappear_animation.play("disappear")
	SignalHub._emit_increase_score()
	#vanish_sound.play()
	
