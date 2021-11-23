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


func _ready() -> void:
	var random_text = flavour_text[randi()%flavour_text.size()]
#	$MarginContainer/VBoxContainer/RichTextLabel.bbcode_text = "[center][shake rate=20 level=5]" + random_text + "[/shake][/center]"
	var time = SaveLoad.time
	var minutes = time/60
	var seconds = time%60
	var time_string = String("%02d" % minutes) + ":" + String("%02d" % seconds)
	$MarginContainer/VBoxContainer/LabelTime.text = "Your time: " + time_string


func _on_Button_pressed() -> void:
	SaveLoad.open_scene("res://scenes/world/World.tscn")
