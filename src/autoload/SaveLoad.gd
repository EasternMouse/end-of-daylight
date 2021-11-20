extends CanvasLayer

var transition_in_progress := false

onready var color_rect := $ColorRect
onready var tween := $Tween


func _ready() -> void:
	transition_in_progress = true
	color_rect.visible = true
	tween.interpolate_property(color_rect.material, "shader_param/cutoff", 0, 1, 1)
	tween.start()
	yield(tween, "tween_all_completed")
	color_rect.visible = false
	transition_in_progress = false


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
