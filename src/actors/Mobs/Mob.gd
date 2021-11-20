extends KinematicBody2D

export var max_life := 10
export var speed := 50
export var damage := 5

var velocity:Vector2
var life := max_life
var target : Vector2
var path : PoolVector2Array

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if speed * delta <= distance_to_next_point:
			pass# The player does not have enough movement left to get to the next point.
		else:
			path.remove(0)
		move_and_slide(position.direction_to(path[0]) * speed)
