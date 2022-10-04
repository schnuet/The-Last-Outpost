extends StaticBody2D

var disabled = false;

#scenemanager
var game;
var player;

func _ready():
	if Globals.get("game_ready") != true:
		yield(SceneManager, "scene_loaded");
	
	game = SceneManager.get_entity("Game");
	player = SceneManager.get_entity("Player");
	
	$Leaf.rotation_degrees = randi() % 90 - 45;

func interact(_player):
	if game.leaf >= 10:
		return;
	
	player.get_node("PickupSound").play();
		
	game.add_leaf(1);
	queue_free();


# remove item from range if we have enough already
func _on_enter_range():
	if game.leaf >= 10:
		player._on_InteractArea2D_body_exited(self);
