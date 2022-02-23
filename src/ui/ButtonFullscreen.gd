extends Button

var icon_normal = preload("res://ui/full.png")
var icon_hover = preload("res://ui/full_hover.png")
var icon_pressed = preload("res://ui/full_pressed.png")

func _ready() -> void:
	pass


func _on_ButtonFullscreen_button_down() -> void:
	icon = icon_pressed


func _on_ButtonFullscreen_button_up() -> void:
	icon = icon_hover


func _on_ButtonFullscreen_mouse_entered() -> void:
	icon = icon_hover


func _on_ButtonFullscreen_mouse_exited() -> void:
	icon = icon_normal
