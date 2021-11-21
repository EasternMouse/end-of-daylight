extends Control

var time = 0

onready var tween = $Tween
onready var label_time = $VBoxContainer/LabelTime


func _ready() -> void:
	modulate = Color.transparent
	Events.connect("weapon_choose", self, "weapon_choose")
	Events.connect("weapon_unlocked", self, "weapon_unlocked")
	Events.connect("weapon_ammo", self, "weapon_ammo")
	Events.connect("game_start", self, "game_start")
	Events.connect("game_over", self, "game_over")
	Events.connect("player_life", self, "player_life")


func game_start() -> void:
	for node in $VBoxContainer/Weapons.get_children():
		node.modulate = Color.darkslategray
	tween.interpolate_property(self, "modulate", modulate, Color.white, 3)
	tween.start()
	$SecondTimer.start()


func weapon_choose(id) -> void:
	for node in $VBoxContainer/Weapons.get_children():
		node.modulate = Color.darkslategray
	var node = get_node("VBoxContainer/Weapons/" + id)
	node.modulate = Color.white


func weapon_unlocked(id) -> void:
	var node = get_node("VBoxContainer/Weapons/" + id)
	node.visible = true

func weapon_ammo(id, ammo) -> void:
	var node = get_node("VBoxContainer/Weapons/" + id)
	node.get_node("VBoxContainer/Ammo").text = String(ammo)


func _on_SecondTimer_timeout() -> void:
	time += 1
	var minutes = time/60
	var seconds = time%60
	label_time.text = String("%02d" % minutes) + ":" + String("%02d" % seconds)
	
	Events.emit_signal("time", time)


func player_life(life) -> void:
	$VBoxContainer/Life/Left.value = life
	$VBoxContainer/Life/Right.value = life


func game_over() -> void:
	SaveLoad.time = time
