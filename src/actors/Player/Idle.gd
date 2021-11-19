
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	
	player.input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 
			Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	if not player.input_vector.is_equal_approx(Vector2.ZERO):
		state_machine.transition_to("Run")


func handle_input(event: InputEvent) -> void:
	pass
