extends Position2D

var is_active := true

func _ready() -> void:
	pass # Replace with function body.



func _on_Position2D_visibility_changed() -> void:
	is_active = true
