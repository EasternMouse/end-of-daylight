extends Area2D

export var damage: int = 1
export var knockback: Vector2 = Vector2.ZERO

var red_particle = preload("res://actors/bullets/red_hit_particle_material.tres")

func _ready() -> void:
	$Particles2D.emitting = true
	$RandomAudioStreamPlayer.play()
	$Line2D/Tween.interpolate_property($Line2D, "modulate", null, Color(0,0,0,0), 0.5)
	$Line2D/Tween.start()


func _physics_process(delta: float) -> void:
	if monitoring:
		var areas = get_overlapping_areas()
		if areas.size() > 0:
			$Particles2D.color = Color.red
			areas[0].damage(damage, knockback)
			monitoring = false


func _on_Timer_timeout() -> void:
	monitoring = false


func _on_TimerDeath_timeout() -> void:
	queue_free()
