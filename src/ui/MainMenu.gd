extends ColorRect

onready var bgm_bus := AudioServer.get_bus_index("BGM")
onready var se_bus := AudioServer.get_bus_index("SE")

onready var bgm_slider := $Settings/VBoxContainer/Music
onready var se_slider := $Settings/VBoxContainer/Sound

onready var tween = $Tween

func _ready() -> void:
	$HowTo.rect_position = Vector2(0, 144)
	
	AudioServer.set_bus_volume_db(se_bus, linear2db(0.7))
	AudioServer.set_bus_volume_db(bgm_bus, linear2db(0.7))
	
	bgm_slider.value = db2linear(AudioServer.get_bus_volume_db(bgm_bus))
	se_slider.value = db2linear(AudioServer.get_bus_volume_db(se_bus))


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


func _on_Sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(se_bus, linear2db(value))


func _on_Music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_bus, linear2db(value))


func _on_ButtonFullscreen_pressed() -> void:
	OS.window_fullscreen = not OS.window_fullscreen
	if OS.window_fullscreen:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
