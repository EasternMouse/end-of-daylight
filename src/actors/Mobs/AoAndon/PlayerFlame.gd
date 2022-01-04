extends Node2D

onready var hitbox = $Area2D
onready var damage = owner.damage

func _ready() -> void:
	set_as_toplevel(true)
	Events.connect("player_position", self, "player_position")


func player_position(pos) -> void:
	global_position = pos


func attack() -> void:
	for area in hitbox.get_overlapping_areas():
		area.damage(damage)
