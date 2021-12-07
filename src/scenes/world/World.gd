extends YSort


func _ready() -> void:
	randomize()
	Events.connect("game_start", self, "game_start")
	Events.connect("game_over", self, "game_over")


func game_start() -> void:
	$AnimationPlayer.play("Sunset")
	$AnimationPlayerBGM.play("to_main")


func game_over() -> void:
	$AnimationPlayerBGM.play("end")
	yield(get_tree().create_timer(2.0), "timeout")
	SaveLoad.open_scene("res://ui/GaveOverScreen.tscn")
