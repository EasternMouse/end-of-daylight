extends Node2D

var credit := 20
var income := 5
var spawn_points = []

var mobs := [
	{cost = 1,
	scene = preload("res://actors/Mobs/Fairy/FairyGreen.tscn"),
	},
]


func _ready() -> void:
	for point in $Spawners.get_children():
		spawn_points.append(point.global_position)
	Events.connect("game_start", self, "game_start")


func _on_Income_timeout() -> void:
	credit += income


func _on_Spawn_timeout() -> void:
	if credit > 0 :
		var mob = mobs[randi()%mobs.size()]
		while mob.cost > credit:
			mob = mobs[randi()%mobs.size()]
		credit -= mob.cost
		
		var spawn_point = spawn_points[randi()%spawn_points.size()]
		var mob_obj = mob.scene.instance()
		mob_obj.global_position = spawn_point
		add_child(mob_obj)


func game_start() -> void:
	$Income.start()
