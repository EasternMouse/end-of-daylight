extends "res://actors/Mobs/Mob.gd"

func melee_attack() -> void:
	if path.size() > 0:
			pivot.rotation = position.direction_to(path[0]).angle()
	for area in melee_hitbox.get_overlapping_areas():
		area.damage(damage)
		$RandomAudioStreamPlayerMelee.play()
