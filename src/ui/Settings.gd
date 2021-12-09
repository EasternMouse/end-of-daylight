extends Control


onready var bgm_bus := AudioServer.get_bus_index("BGM")
onready var se_bus := AudioServer.get_bus_index("SE")

onready var bgm_slider := $VBoxContainer/Music
onready var se_slider := $VBoxContainer/Sound

func _ready() -> void:
	bgm_slider.value = db2linear(AudioServer.get_bus_volume_db(bgm_bus))
	se_slider.value = db2linear(AudioServer.get_bus_volume_db(se_bus))

func _on_Sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(se_bus, linear2db(value))


func _on_Music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_bus, linear2db(value))


func _on_ButtonFullscreen_pressed() -> void:
	OS.window_fullscreen = not OS.window_fullscreen
