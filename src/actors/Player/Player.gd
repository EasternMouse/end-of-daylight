
class_name Player
extends KinematicBody2D


export var ACCELERATION: float = 1000.0
export var MAX_SPEED: float = 150.0
export var FRICTION: float = 1000.0

var input_vector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var state_machine := $StateMachine
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
onready var sprite: Sprite = $Sprite


func _ready() -> void:
	pass
