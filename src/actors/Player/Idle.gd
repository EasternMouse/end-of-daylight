
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animation_state_bottom.travel("Idle")
	player.animation_state_top.travel("Aim")


func physics_update(_delta: float) -> void:
	
	player.input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 
			Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	if not player.direction_locked:
		var mouse_pos = get_viewport().get_mouse_position()
		player.pivot.rotation = (get_viewport().size/2).angle_to_point(mouse_pos)
		player.animation_tree_top.set("parameters/Aim/blend_position", -Vector2(cos(player.pivot.rotation), sin(player.pivot.rotation)).normalized())
	
	if not player.input_vector.is_equal_approx(Vector2.ZERO):
		state_machine.transition_to("Run")
	
	if Input.is_action_pressed("attack"):
		if not player.shgooting_player.is_playing():
			player.shgooting_player.play(player.current_weapon.name)

