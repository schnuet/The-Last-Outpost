extends Control

export var value = 0;
export var max_value = 100;

onready var fill = $ColorRect;

var max_width = 0;
var game_time = 210;

func _ready():
	max_width = fill.rect_size.x;
	fill.rect_size.x = 0;
	var left = fill.rect_position.x;

	
	$Tween.interpolate_property(fill, "rect_size:x", 0, max_width, game_time, Tween.TRANS_LINEAR);
	$Tween.interpolate_property(fill, "rect_position:x", left + max_width, left + 0, game_time, Tween.TRANS_LINEAR);
	$Tween.start();
	

#func set_value(val):
#	value = val;
#
#	fill.rect_size.x = (value / max_value) * max_width;



func _on_Tween_tween_all_completed():
	Globals.set("game_ready", false);
	SceneManager.change_scene("res://scenes/04_win/SceneWin.tscn");


func _on_Timer_timeout():
	var _c = $Tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed");
