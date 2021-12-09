extends CanvasLayer

var transition_in_progress := false

var time := 0

onready var color_rect := $ColorRect
onready var tween := $Tween

onready var bgm_bus := AudioServer.get_bus_index("BGM")
onready var se_bus := AudioServer.get_bus_index("SE")


func _ready() -> void:
	AudioServer.set_bus_volume_db(se_bus, linear2db(0.7))
	AudioServer.set_bus_volume_db(bgm_bus, linear2db(0.7))
	transition_in_progress = true
	color_rect.visible = true
	tween.interpolate_property(color_rect.material, "shader_param/cutoff", 0, 1, 1)
	yield(get_tree().create_timer(0.5), "timeout")
	tween.start()
	yield(tween, "tween_all_completed")
	color_rect.visible = false
	transition_in_progress = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen


func open_scene(new_scene: String):
	if transition_in_progress:
		return
	transition_in_progress = true
	color_rect.visible = true
	tween.interpolate_property(color_rect.material, "shader_param/cutoff", 1, 0, 1)
	tween.start()
	yield(tween, "tween_all_completed")
	yield(get_tree().create_timer(0.25), "timeout")
	var err = get_tree().change_scene(new_scene)
	if err != OK:
		print("Can't change scene! ", new_scene)
	tween.interpolate_property(color_rect.material, "shader_param/cutoff", 0, 1, 1)
	tween.start()
	yield(tween, "tween_all_completed")
	color_rect.visible = false
	transition_in_progress = false
