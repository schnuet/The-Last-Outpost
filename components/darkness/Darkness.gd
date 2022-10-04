extends Node2D

onready var timer = $Timer;
onready var eyes = $Eyes.get_children();

var original_eye_positions = [];
var hidden_eyes = [];
var visible_eyes = [];


func _ready():
	for eye_index in range(eyes.size()):
		var eye = eyes[eye_index];
		original_eye_positions.append(eye.global_position);
	hide_all_eyes();

func hide_all_eyes():
	for eye_index in range(eyes.size()):
		hide_eye(eye_index);
		
func show_random_eye():
	if hidden_eyes.size() == 0:
		return;
	var random_index = ArrayUtil.get_rand(hidden_eyes);
	show_eye(random_index);

func show_eye(eye_index: int):
	eyes[eye_index].show();
	var original_position = original_eye_positions[eye_index];
	eyes[eye_index].global_position = Vector2(original_position.x + randi() % 6 - 3, original_position.y + randi() % 6 - 3);
	hidden_eyes.erase(eye_index);
	visible_eyes.append(eye_index);

func hide_eye(eye_index: int):
	eyes[eye_index].hide();
	hidden_eyes.append(eye_index);
	visible_eyes.erase(eye_index);


func _on_Timer_timeout():
	hide_all_eyes();


func _on_EyeTimer_timeout():
	if hidden_eyes.size() == 0:
		return
		
	var percent_time_remaining = (10 - timer.time_left) / 10;
	var limit = pow(percent_time_remaining, 3) ;
	var rand_num = randf();
	if rand_num <= limit:
		show_random_eye();
