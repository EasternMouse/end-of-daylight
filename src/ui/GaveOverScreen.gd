extends Control

var flavour_text = [
	"This is the end",
	"Light is no more",
	"Lost to the darkness",
	"Endless darkness",
	"You can't see a thing anymore",
	"Alone in the dark",
	"Not alone in the dark",
	"No more light",
	"Deaf to all but the dark",
	"Nothing to see now",
	"Welcome to Shadow Realm",
	"The sun sets, everything ends",
	"From now on, the power of darkness",
	"Sadness, loneliness, pain, despair",
	"Throw your hope away",
	"This is the true freedom, isn't it",
	"Now again, something disappears",
]


class SortHighScore:
	static func sort_descending(a, b):
		if a.time > b.time:
			return true
		return false


func _ready() -> void:
	var random_text = flavour_text[randi()%flavour_text.size()]
	$MarginContainer/VBoxContainer/RichTextLabel.bbcode_text = "[center][shake rate=1000 level=6]" + random_text + "[/shake][/center]"
	var time = SaveLoad.time
	var minutes = time/60
	var seconds = time%60
	var time_string = String("%02d" % minutes) + ":" + String("%02d" % seconds)
	$MarginContainer/VBoxContainer/LabelTime.text = "Your time: " + time_string
	
	$MarginContainer/VBoxContainer/LineEdit.grab_focus()


func _on_Button_pressed() -> void:
	save_high_score()
	SaveLoad.open_scene("res://scenes/world/World.tscn")


func save_high_score() -> void:
	var save_file = File.new()
	var save := {}
	
	var err = save_file.open("user://high_score.sav", File.READ_WRITE)
	if err != OK:
		save = {
			death_count = 1,
			high_score = [{
				name = "Mouse",
				time = 228,
			}],
		}
	else:
		save = save_file.get_var()
		if save == null:
			save = {
			death_count = 1,
			high_score = [{
				name = "Mouse",
				time = 228,
			}],
		}
	save_file.open("user://high_score.sav", File.WRITE)
	
	var player_name = $MarginContainer/VBoxContainer/LineEdit.text if $MarginContainer/VBoxContainer/LineEdit.text != "" else "You"
	var new_line = {
		name = player_name,
		time = SaveLoad.time,
		}
	
	if save.death_count == 1:
		var reimu_line = {
			name = "Reimu",
			time = 312,
		}
		save.high_score.append(reimu_line)
	
	save.high_score.append(new_line)
	save.high_score.sort_custom(SortHighScore, "sort_descending")
	save.death_count += 1
	save_file.store_var(save)
	save_file.close()
