extends ColorRect

onready var tween = $Tween


func _ready() -> void:
	$HowTo.rect_position = Vector2(0, 144)


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("pause"):
		get_tree().set_input_as_handled()


func _on_ButtonStart_pressed() -> void:
	tween.interpolate_property(self, "modulate", modulate, Color(0, 0, 0, 0), 1)
	tween.start()
	yield(tween, "tween_all_completed")
	Events.emit_signal("game_start")
	visible = false


func _on_ButtonQuit_pressed() -> void:
	get_tree().quit()


func _on_ButtonHowTo_pressed() -> void:
	$HowTo.visible = true
	tween.interpolate_property($HowTo, "rect_position", Vector2(0, 144), Vector2(0, 0), 0.5)
	tween.start()


func _on_ButtonBack_pressed() -> void:
	tween.interpolate_property($HowTo, "rect_position", Vector2(0, 0), Vector2(0, 144), 0.5)
	tween.start()
