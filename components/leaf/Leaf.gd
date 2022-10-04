extends StaticBody2D

var disabled = false;

#scenemanager
var game;

func _ready():
	if Globals.get("game_ready") != true:
		yield(SceneManager, "scene_loaded");
	
	game = SceneManager.get_entity("Game");
	
	$Leaf.rotation_degrees = randi() % 90 - 45;

func interact(player):
	if game.leaf >= 10:
		return;
	
	player.get_node("PickupSound").play();
		
	game.add_leaf(1);
	queue_free();
