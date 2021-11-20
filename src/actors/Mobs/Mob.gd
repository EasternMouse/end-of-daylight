extends KinematicBody2D

export var max_life := 10
export var speed := 50
export var damage := 5

var is_alive := true

var velocity : Vector2
var life := max_life
var target : Vector2
var path : PoolVector2Array
var knockback_velocity : Vector2


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


func damage(damage:int, knockback:Vector2) -> void:
	if is_alive:
		life -= damage
		
		if knockback != Vector2.dsZERO:
			move_and_slide(knockback * 100)
		
		if life <= 0:
			die()


func die() -> void:
	queue_free()
