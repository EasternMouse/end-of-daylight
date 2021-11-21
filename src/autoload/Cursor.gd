extends Sprite


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position()
