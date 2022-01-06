
class_name Player
extends KinematicBody2D


export var ACCELERATION: float = 1000.0
export var MAX_SPEED: float = 150.0
export var FRICTION: float = 1000.0
export var MAX_LIFE: int = 100

onready var life := MAX_LIFE

export var direction_locked := false


var weapons := {
	melee = {
		name = "melee",
		damage = 3,
		ammo = 0,
		uses_ammo = false,
		unlocked = true,
		next = "seal",
		previous = "orb",
	},
	seal = {
		name = "seal",
		damage = 1,
		ammo = 0,
		uses_ammo = false,
		unlocked = true,
		cx = 5,
		cy = 2,
		burst = 1,
		next = "needle",
		previous = "melee",
		trace_color = Color.red,
	},
	needle = {
		name = "needle",
		damage = 1,
		ammo = 10,
		uses_ammo = true,
		unlocked = false,
		cx = 20,
		cy = 10,
		burst = 10,
		next = "orb",
		previous = "seal",
		trace_color = Color.gray,
	},
	orb = {
		name = "orb",
		damage = 10,
		ammo = 3,
		uses_ammo = true,
		unlocked = false,
		cx = 10,
		cy = 5,
		burst = 1,
		next = "melee",
		previous = "needle",
	},
}

var current_weapon = weapons.seal

var bullet_scene := preload("res://actors/bullets/Bullet.tscn")
var world: Node2D

var input_vector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var state_machine := $StateMachine
onready var animation_player_bottom: AnimationPlayer = $AnimationPlayerBottom
onready var animation_tree_bottom: AnimationTree = $AnimationTreeBottom
onready var animation_state_bottom: AnimationNodeStateMachinePlayback = animation_tree_bottom.get("parameters/playback")
onready var animation_player_top: AnimationPlayer = $AnimationPlayerTop
onready var animation_tree_top: AnimationTree = $AnimationTreeTop
onready var animation_state_top: AnimationNodeStateMachinePlayback = animation_tree_top.get("parameters/playback")
onready var shgooting_player: AnimationPlayer = $ShootingPlayer
onready var pivot: Position2D = $Pivot
onready var sprite_bottom: Sprite = $SpriteBottom
onready var sprite_top: Sprite = $SpriteTop

onready var melee_hitbox := $Pivot/Melee

onready var random := RandomNumberGenerator.new()

func _ready() -> void:
	animation_tree_bottom.set("parameters/Idle/blend_position", Vector2.DOWN)
	animation_tree_bottom.set("parameters/Run/blend_position", Vector2.DOWN)
	
	animation_tree_top.set("parameters/Aim/blend_position", Vector2.DOWN)
	
	Events.connect("game_start", self, "game_start")
	Events.connect("weapon_choose", self, "weapon_choose")
	
	var nodes_world = get_tree().get_nodes_in_group("world")
	if nodes_world.size() > 0:
		world = nodes_world[0]
	else:
		world = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next"):
		var selected = weapons[current_weapon.next]
		while !selected.unlocked:
			selected = weapons[selected.next]
		Events.emit_signal("weapon_choose", selected.name)
	elif event.is_action_pressed("previous"):
		var selected = weapons[current_weapon.previous]
		while !selected.unlocked:
			selected = weapons[selected.previous]
		Events.emit_signal("weapon_choose", selected.name)
	
	elif event.is_action_pressed("1") and weapons.melee.unlocked:
		Events.emit_signal("weapon_choose", "melee")
	elif event.is_action_pressed("2") and weapons.seal.unlocked:
		Events.emit_signal("weapon_choose", "seal")
	elif event.is_action_pressed("3") and weapons.needle.unlocked:
		Events.emit_signal("weapon_choose", "needle")
	elif event.is_action_pressed("4") and weapons.orb.unlocked:
		Events.emit_signal("weapon_choose", "orb")


func weapon_choose(weapon_name) -> void:
	current_weapon = weapons[weapon_name]

func game_start():
	animation_tree_bottom.active = true
	animation_tree_top.active = true
	
	Events.emit_signal("weapon_choose", "seal")


func transition_to_idle() -> void:
	state_machine.transition_to("Idle")


func _physics_process(_delta: float) -> void:
	Events.emit_signal("player_position", global_position)


func melee_attack() -> void:
	var did_hit = false
	for area in melee_hitbox.get_overlapping_areas():
		area.damage(weapons.melee.damage, -Vector2(cos(pivot.rotation), sin(pivot.rotation)))
		did_hit = true
	if did_hit:
		$ShootingPlayer/RandomAudioStreamPlayer.play()


func bullet_attack() -> void:
	if not current_weapon.uses_ammo or current_weapon.ammo > 0:
		for i in current_weapon.burst:
			var mouse_pos = get_viewport().get_mouse_position() - get_viewport().size/2
			var variation = get_random_point_in_circle(current_weapon.cx, current_weapon.cy)
			var bullet = bullet_scene.instance()
			bullet.global_position = pivot.global_position + mouse_pos + variation
			var path_vector = PoolVector2Array([0.0, -(mouse_pos + variation)])
			bullet.get_node("Line2D").points = path_vector
			bullet.get_node("Line2D").modulate = current_weapon.trace_color
			world.add_child(bullet)
		if current_weapon.uses_ammo:
			current_weapon.ammo -= 1
			Events.emit_signal("weapon_ammo", current_weapon.name, current_weapon.ammo)


func get_random_point_in_circle(cx, cy) -> Vector2:
	var angle = random.randf() * 2 * PI
	var d = abs(random.randfn(0.0, 0.5))
	var new_point = Vector2(sin(angle) * d * cx, cos(angle) * d * cy)
	return new_point


func _on_PickupArea2D_area_entered(area: Area2D) -> void:
	if area.item == null:
		pass
	if area.item.name == "weapon_needle":
		var weapon = weapons.needle
		if not weapon.unlocked:
			weapon.unlocked = true
			Events.emit_signal("weapon_unlocked", weapon.name)
		weapon.ammo += area.item.amount
		Events.emit_signal("weapon_ammo", weapon.name, weapon.ammo)
	area.queue_free()


func damage(damage_value) -> void:
	if state_machine.state.name != "Cutscene":
		life -= damage_value
		Events.emit_signal("player_life", life)
		if life <= 0:
			state_machine.transition_to("Cutscene")
			animation_player_top.play_backwards("Sit")
			animation_player_bottom.play_backwards("Sit")
			Events.emit_signal("game_over")
