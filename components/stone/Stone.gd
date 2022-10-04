extends StaticBody2D

var disabled = false;

var game;
var player;

func _ready():
	if Globals.get("game_ready") != true:
		yield(SceneManager, "scene_loaded");
		
	game = SceneManager.get_entity("Game");
	player = SceneManager.get_entity("Player");
	
	$Stone.rotation_degrees = randi() % 10 - 5;
	
func interact(_player: KinematicBody2D):
	if game.stone >= 10:
		return;
	
	player.get_node("PickupSound").play();
	
	game.add_stone(1);
	queue_free()


# remove item from range if we have enough already
func _on_enter_range():
	if game.stone >= 10:
		player._on_InteractArea2D_body_exited(self);
