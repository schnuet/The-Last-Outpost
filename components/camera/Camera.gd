extends Camera2D

var player;

const room_height = 720;
var game_height = 4 * room_height;

func _ready():
	yield(SceneManager, "scene_loaded");
	player = SceneManager.get_entity("Player");

func _process(_delta):
	
	var target_y = global_position.y;
	
	if player.global_position.y <= 600:
		target_y = 360;
	elif player.global_position.y > game_height - room_height / 2:
		target_y = game_height - room_height / 2;
	else:
		target_y = player.global_position.y;
	
	if player.global_position.y > 600 && player.global_position.y < 800:
		var p_y_percent = (player.global_position.y - 600) / 200;
		smoothing_speed = 2 + 18 * p_y_percent;
		target_y = player.global_position.y - (player.global_position.y - 360) * (1 - p_y_percent);
	elif player.global_position.y <= 600:
		smoothing_speed = 2;
	else:
		smoothing_speed = 20;
	
	global_position.y = target_y;
	
#	if global_position.y != target_y:
#		global_position.y += (target_y - global_position.y) * (delta * zoom_speed);
	
	

