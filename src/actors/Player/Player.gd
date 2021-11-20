
class_name Player
extends KinematicBody2D


export var ACCELERATION: float = 1000.0
export var MAX_SPEED: float = 150.0
export var FRICTION: float = 1000.0
export var MAX_LIFE: int = 100

export var direction_locked := false


var weapons := {
	melee = {
		name = "melee",
		damage = 3,
		ammo = 0,
		uses_ammo = false,
		unlocked = true,
	},
	seal = {
		name = "seal",
		damage = 1,
		ammo = 0,
		uses_ammo = false,
		unlocked = true,
	},
}

var current_weapon = weapons.seal


var input_vector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var state_machine := $StateMachine
onready var animation_player_bottom: AnimationPlayer = $AnimationPlayerBottom
onready var animation_tree_bottom: AnimationTree = $AnimationTreeBottom
onready var animation_state_bottom: AnimationNodeStateMachinePlayback = animation_tree_bottom.get("parameters/playback")
onready var animation_player_top: AnimationPlayer = $AnimationPlayerTop
onready var animation_tree_top: AnimationTree = $AnimationTreeTop
onready var shgooting_player: AnimationPlayer = $ShootingPlayer
onready var pivot: Position2D = $Pivot
onready var sprite_bottom: Sprite = $SpriteBottom
onready var sprite_top: Sprite = $SpriteTop

onready var melee_hitbox := $Pivot/Melee


func _ready() -> void:
	animation_tree_bottom.active = true
	animation_tree_bottom.set("parameters/Idle/blend_position", Vector2.DOWN)
	animation_tree_bottom.set("parameters/Run/blend_position", Vector2.DOWN)
	
	animation_tree_top.active = true
	animation_tree_top.set("parameters/blend_position", Vector2.DOWN)
	
	Events.connect("game_start", self, "game_start")


func game_start():
	state_machine.transition_to("Idle")


func _physics_process(_delta: float) -> void:
	Events.emit_signal("player_position", global_position)


func melee_attack() -> void:
	for area in melee_hitbox.get_overlapping_areas():
		area.damage(weapons.melee.damage, Vector2(-cos(pivot.rotation), sin(pivot.rotation)))


func bullet_attack() -> void:
	pass
