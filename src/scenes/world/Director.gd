extends Node2D

var credit := 0
var income := 5
var income_increase := 1
var spawn_points = []

var mobs := [
	{
		cost = 1,
		name = "FairyGreen",
		limit = 40,
		scene = preload("res://actors/Mobs/Fairy/FairyGreen.tscn"),
	},
	{
		cost = 6,
		name = "FairyBlue",
		scene = preload("res://actors/Mobs/Fairy/FairyBlue.tscn"),
	},
	{
		cost = 18,
		name = "FairyRed",
		scene = preload("res://actors/Mobs/Fairy/FairyRed.tscn"),
	},
	{
		cost = 10,
		name = "BigFairyGreen",
		scene = preload("res://actors/Mobs/BigFairy/BigFairyGreen.tscn"),
	},
	{
		cost = 28,
		name = "BigFairyBlue",
		scene = preload("res://actors/Mobs/BigFairy/BigFairyBlue.tscn"),
	},
	{
		cost = 60,
		name = "BigFairyRed",
		scene = preload("res://actors/Mobs/BigFairy/BigFairyRed.tscn"),
	},
]


func _ready() -> void:
	for point in $Spawners.get_children():
		spawn_points.append(point)
	Events.connect("game_start", self, "game_start")
	Events.connect("game_over", self, "game_over")


func _on_Income_timeout() -> void:
	credit += income
	income += income_increase
	print("Income! Current creds: ", credit, " Income: ", income)
	print("Green fairies: ", get_tree().get_nodes_in_group("FairyGreen").size(), " out of ", get_tree().get_nodes_in_group("Mobs").size(), " mobs")


func _on_Spawn_timeout() -> void:
	if credit > 0 :
		var mob = mobs[randi()%mobs.size()]
		var retry_count := 0
		var retry_limit = 60
		while retry_count < retry_limit and (mob.cost > credit or (mob.has("limit") and get_tree().get_nodes_in_group(mob.name).size() > mob.limit)):
			mob = mobs[randi()%mobs.size()]
			retry_count += 1
		if retry_count >= retry_limit:
			return
		credit -= mob.cost
		
		var spawn_point = spawn_points[randi()%spawn_points.size()]
		while spawn_point.is_on_screen():
			spawn_point = spawn_points[randi()%spawn_points.size()]
		var mob_obj = mob.scene.instance()
		mob_obj.global_position = spawn_point.global_position
		add_child(mob_obj)


func game_start() -> void:
	$Income.start()
	$Spawn.start()


func game_over() -> void:
	$Income.stop()
	$Spawn.stop()
