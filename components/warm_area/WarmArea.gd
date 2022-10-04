extends Area2D

var healing_power = 1;

onready var timer = $Timer;

# scenemanager entity
var player;

func _ready():
	yield(SceneManager, "scene_loaded");
	player = SceneManager.get_entity("Player");

func _on_Timer_timeout():
	player.heal_cold_damage(healing_power);


func _on_WarmArea_body_entered(_player):
	if timer.is_stopped():
		print("entered warm area");
		timer.start(10);


func _on_WarmArea_body_exited(_player):
	print("left warm area");
	timer.stop();
