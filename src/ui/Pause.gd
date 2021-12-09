extends Popup


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("pause"):
		get_tree().set_input_as_handled()
		get_tree().paused = false
		hide()


func _on_ButtonContinue_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_ButtonMainMenu_pressed() -> void:
	SaveLoad.open_scene("res://scenes/world/World.tscn")

