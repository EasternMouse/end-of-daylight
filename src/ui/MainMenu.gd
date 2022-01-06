extends ColorRect

onready var tween = $Tween
onready var high_score_line = preload("res://ui/HighScoreLine.tscn")


func _ready() -> void:
	$HighScore.visible = false
	$HowTo.rect_position = Vector2(0, 144)
	load_high_score()


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
	SaveLoad.quit()


func _on_ButtonHowTo_pressed() -> void:
	$HowTo.visible = true
	tween.interpolate_property($HowTo, "rect_position", Vector2(0, 144), Vector2(0, 0), 0.5)
	tween.start()


func _on_ButtonBack_pressed() -> void:
	tween.interpolate_property($HowTo, "rect_position", Vector2(0, 0), Vector2(0, 144), 0.5)
	tween.start()


func load_high_score() -> void:
	var save_file = File.new()
	var err = save_file.open("user://high_score.sav", File.READ)
	if err == OK:
		var save: Dictionary = save_file.get_var()
		if save.has("high_score"):
			$HighScore.visible = true
			for line in save.high_score:
				var new_line = high_score_line.instance()
				new_line.get_node("Name").text = line.name
				var minutes = line.time/60
				var seconds = line.time%60
				var time_string = String("%02d" % minutes) + ":" + String("%02d" % seconds)
				new_line.get_node("Time").text = time_string
				$HighScore/ScrollContainer/VBoxContainer.add_child(new_line)
