extends Area2D

var damage = 1;

onready var player: Player;
onready var timer = $Timer;

func _ready():
	yield(SceneManager, "scene_loaded");
	
	player = SceneManager.get_entity("Player");

func _on_ColdArea_body_entered(_player):
	_player.light_on = true;
	_player.speed = _player.speed_in_snow;
	
	if timer.is_stopped():
		print("entered cold area");
		timer.start(10);


func _on_ColdArea_body_exited(_player):
	_player.light_on = false;
	_player.speed = _player.speed_in_camp;
	
	print("left cold area");
	timer.stop();


func _on_Timer_timeout():
	player.add_cold_damage(damage);
