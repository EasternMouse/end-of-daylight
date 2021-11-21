extends Area2D


var item = null


func _ready() -> void:
	if item == null:
		queue_free()
		return
	$Sprite.texture = item.sprite
