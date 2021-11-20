extends ColorRect

onready var tween = $Tween

func _ready() -> void:
	pass


func _on_ButtonStart_pressed() -> void:
	tween.interpolate_property(self, "modulate", modulate, Color(0, 0, 0, 0), 1)
	tween.start()
	yield(tween, "tween_all_completed")
	Events.emit_signal("game_start")
	visible = false


func _on_ButtonQuit_pressed() -> void:
	pass
