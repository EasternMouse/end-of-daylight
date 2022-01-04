extends "res://actors/Mobs/Mob.gd"


func _ready() -> void:
	pass


func _on_PlayerDetector_area_entered(area: Area2D) -> void:
	if not $AnimationPlayer.current_animation == "die":
		$AnimationPlayer.play(melee_animation)
