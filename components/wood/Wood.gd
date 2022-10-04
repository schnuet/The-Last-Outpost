extends StaticBody2D

var disabled = false;

# scenemanager entity;
var game;

func _ready():
	if Globals.get("game_ready") != true:
		yield(SceneManager, "scene_loaded");
		
	game = SceneManager.get_entity("Game");
	
	$Wood.rotation_degrees = randi() % 90 - 45;
	
func interact(player: KinematicBody2D):
	if game.wood >= 10:
		return;
	
	player.get_node("PickupSound").play();
		
	game.wood += 1;
	queue_free();
