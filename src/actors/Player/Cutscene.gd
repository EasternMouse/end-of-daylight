
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animation_state_bottom.travel("Idle")

