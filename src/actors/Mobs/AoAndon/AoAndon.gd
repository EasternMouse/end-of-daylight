extends "res://actors/Mobs/Mob.gd"

onready var fire_animation = $Flames/AnimationPlayer


func _ready() -> void:
	pass


func _on_PlayerDetector_area_entered(area: Area2D) -> void:
	if not $AnimationPlayer.current_animation == "ao_die":
		fire_animation.play("Fire")


func _on_PlayerDetector_area_exited(area: Area2D) -> void:
	fire_animation.play("RESET")


func die() -> void:
	spawn_item()
	$AnimationPlayer.play("ao_die")
	$Flames/AnimationPlayer.play("RESET")
	$RandomAudioStreamPlayer.play()
