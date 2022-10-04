extends AudioStreamPlayer

export var target_volume = 0;

func _ready():
	volume_db = -70;
	var tween = Tween.new();
	add_child(tween);
	tween.interpolate_property(self, "volume_db", -70, target_volume, 1, Tween.TRANS_QUAD, Tween.EASE_OUT);
	tween.start();
	play();
