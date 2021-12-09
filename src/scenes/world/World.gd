extends YSort

onready var pause_popup : Popup = $UI/Pause


func _ready() -> void:
	randomize()
	Events.connect("game_start", self, "game_start")
	Events.connect("game_over", self, "game_over")


func game_start() -> void:
	$AnimationPlayer.play("Sunset")
	$AnimationPlayerBGM.play("to_main")


func game_over() -> void:
	$AnimationPlayerBGM.play("end")
	yield(get_tree().create_timer(2.0), "timeout")
	SaveLoad.open_scene("res://ui/GaveOverScreen.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().set_input_as_handled()
		get_tree().paused = true
		pause_popup.popup()
