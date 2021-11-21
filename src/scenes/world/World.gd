extends YSort


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("game_start", self, "game_start")


func game_start() -> void:
	$AnimationPlayer.play("Sunset")
