extends Navigation2D


func _ready() -> void:
	Events.connect("player_position", self, "player_position")


func player_position(pos):
	for mob in get_tree().get_nodes_in_group("Mobs"):
		mob.path = get_simple_path(mob.global_position, pos)
