
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animation_state_bottom.travel("Run")


func physics_update(delta: float) -> void:
	
	player.input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 
			Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	if not player.direction_locked:
		var mouse_pos = get_viewport().get_mouse_position()
		player.pivot.rotation = (get_viewport().size/2).angle_to_point(mouse_pos)
		player.animation_tree_top.set("parameters/Aim/blend_position", -Vector2(cos(player.pivot.rotation), sin(player.pivot.rotation)).normalized())
	
	if player.input_vector != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(player.input_vector * player.MAX_SPEED, player.ACCELERATION * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.FRICTION * delta)
	
	player.velocity = player.move_and_slide(player.velocity)
	
	if Input.is_action_pressed("attack"):
		player.shgooting_player.play(player.current_weapon.name)
	
	
	if player.velocity.is_equal_approx(Vector2.ZERO):
		state_machine.transition_to("Idle")
	else:
		player.animation_tree_bottom.set("parameters/Idle/blend_position", player.velocity)
		player.animation_tree_bottom.set("parameters/Run/blend_position", player.velocity)
