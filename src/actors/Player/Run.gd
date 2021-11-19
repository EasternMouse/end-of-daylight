
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO


func physics_update(delta: float) -> void:
	
	player.input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 
			Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	if player.input_vector != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(player.input_vector * player.MAX_SPEED, player.ACCELERATION * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.FRICTION * delta)
	player.velocity = player.move_and_slide(player.velocity)
	
	if player.velocity.is_equal_approx(Vector2.ZERO):
		state_machine.transition_to("Idle")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		pass
