extends KinematicBody2D

export var max_life := 1
export var speed := 50
export var damage := 5

export var speed_multiplier := 1

export var item_multiplier := 1

var is_alive := true

var velocity : Vector2
onready var life := max_life
var target : Vector2
var path : PoolVector2Array
var knockback_velocity : Vector2

var drop_table = [
	{weight = 0.80,
	item = "weapon_needle",
	},
]
var item_scene = preload("res://actors/items/ItemDrop.tscn")


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	if knockback_velocity != Vector2.ZERO:
		move_and_slide(knockback_velocity)
		knockback_velocity = knockback_velocity * 0.9
	elif path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if speed * delta > distance_to_next_point:
			path.remove(0)
		move_and_slide(position.direction_to(path[0]) * speed * speed_multiplier)


func damage(received_damage:int, knockback:Vector2) -> void:
	if is_alive:
		life -= received_damage
		
		if knockback != Vector2.ZERO:
			knockback_velocity = knockback * 300
			$KnockbackTimer.start()
		
		if life <= 0:
			die()


func die() -> void:
	spawn_item()
	$AnimationPlayer.play("die")


func _on_KnockbackTimer_timeout() -> void:
	knockback_velocity = Vector2.ZERO


func spawn_item() -> void:
	var points = randf() * item_multiplier
	for item_name in DropTable.items:
		if points <= DropTable.items[item_name].weight:
			var new_item = item_scene.instance()
			new_item.item = DropTable.items[item_name]
			new_item.global_position = global_position
			var nodes_world = get_tree().get_nodes_in_group("world")
			if nodes_world.size() > 0:
				nodes_world[0].add_child(new_item)
		else:
			points -= DropTable.items[item_name].weight
