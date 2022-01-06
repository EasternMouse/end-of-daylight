extends "res://actors/Mobs/Mob.gd"

var target_position = Vector2.ZERO

func _ready() -> void:
	Events.connect("player_position", self, "player_position")


func _physics_process(delta: float) -> void:
	if position.distance_to(target_position) > 11:
		velocity = move_and_slide(position.direction_to(target_position) * speed * speed_multiplier)


func move_along_path(delta: float) -> void:
	pass #not move along path as original mob do


func player_position(pos) -> void:
	target_position = pos


func damage(received_damage:int, knockback:Vector2) -> void:
	if is_alive:
		if knockback == Vector2.ZERO:
			life -= received_damage
		
		if life <= 0:
			die()
