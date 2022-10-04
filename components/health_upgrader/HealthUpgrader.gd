class_name HealthUpgrader
extends StaticBody2D

var required_wood = 0;
var required_stone = 0;
var required_leaf = 2;

var upgrade_count = 0;
var interact_available = false;

var disabled = false;

#scenemanager
var game;
var player: Player;

func _ready():
	yield(SceneManager, "scene_loaded");
	game = SceneManager.get_entity("Game");
	player = SceneManager.get_entity("Player");
	
	$RequirementsOverlay.hide();

func _process(_delta):
	interact_available = game.has_resources(required_wood, required_stone, required_leaf);
	
func interact(_player):
	if disabled:
		return;
	
	if game.consume_resources(required_wood, required_stone, required_leaf):
		player.increase_level();
		upgrade_count += 1;
		increase_next_resource_requirements();
		
		$AudioStreamPlayer.play(0);
		
		if player.level >= 3:
			disable();
	else:
		print("not enough resources");

func increase_next_resource_requirements():
	required_leaf += 1;

func disable():
	disabled = true;
	$SelfLight.energy = 0.2;
	_on_leave_range();
	

func _on_enter_range():
	$AnimatedSprite.animation = "active";
	$RequirementsOverlay.show();

func _on_leave_range():
	$AnimatedSprite.animation = "default";
	$RequirementsOverlay.hide();
