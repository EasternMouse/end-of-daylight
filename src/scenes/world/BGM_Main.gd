extends AudioStreamPlayer


var previous_life: int = 100

var speed = 0.3

onready var tween: Tween = $Tween


func _ready() -> void:
	Events.connect("player_life", self, "player_life")


func player_life(value) -> void:
	if value < previous_life:
		previous_life = value
		tween.stop_all()
		var new_volume = clamp(db2linear(volume_db)-0.3, 0.05, 1)
		var new_pitch = clamp(pitch_scale-0.03, 0.8, 1)
		
		tween.interpolate_property(self, "pitch_scale", null, new_pitch, 0.25, Tween.TRANS_CIRC, Tween.EASE_IN)
		tween.interpolate_property(self, "volume_db", null, linear2db(new_volume), 0.25, Tween.TRANS_CIRC, Tween.EASE_IN)
		
		tween.interpolate_property(self, "pitch_scale", new_pitch, 1, 1/new_volume*speed, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.25)
		tween.interpolate_property(self, "volume_db", linear2db(new_volume), -5, 1/new_volume*speed, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.25)
		tween.start()
