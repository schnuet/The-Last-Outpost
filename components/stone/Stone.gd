extends StaticBody2D

var disabled = false;

var game;

func _ready():
	if Globals.get("game_ready") != true:
		yield(SceneManager, "scene_loaded");
	game = SceneManager.get_entity("Game");
	
	$Stone.rotation_degrees = randi() % 10 - 5;
	
func interact(player: KinematicBody2D):
	if game.stone >= 10:
		return;
	
	player.get_node("PickupSound").play();
	
	game.add_stone(1);
	queue_free()
