extends KinematicBody2D

export var max_life := 10
export var speed := 50

var velocity:Vector2
var life := max_life
var target : Vector2
var path : PoolVector2Array

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	var distance_to_walk = speed * delta
	
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
