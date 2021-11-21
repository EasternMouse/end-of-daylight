
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animation_state_bottom.travel("Idle")
	player.animation_tree_bottom.active = false
	player.animation_tree_top.active = false
