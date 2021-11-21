extends Node

var items = {
}

var timed_items = {
	weapon_needle = {
		time = 20,
		name = "weapon_needle",
		weight = 0.25,
		sprite = preload("res://ui/player_ui/weapon_needle.png"),
		amount = 10,
	}
}
func _ready() -> void:
	Events.connect("time", self, "time")


func time(time) -> void:
	for item in timed_items:
		if timed_items[item].time <= time:
			items[item] = timed_items[item]
			timed_items.erase(item)
			print(item, " unlocked")
