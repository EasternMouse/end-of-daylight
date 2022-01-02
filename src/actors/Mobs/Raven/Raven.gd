extends "res://actors/Mobs/Mob.gd"


func damage(received_damage:int, knockback:Vector2) -> void:
	if is_alive:
		if knockback == Vector2.ZERO:
			life -= received_damage
		
		if life <= 0:
			die()
