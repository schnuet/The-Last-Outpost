class_name FireUpgrader
extends StaticBody2D

var required_wood = 3;
var required_stone = 2;
var required_leaf = 0;

var upgrade_count = 0;
var interact_available = false;

var disabled = false;

# scenemanager entities
var game;
var fire;

func _ready():
	yield(SceneManager, "scene_loaded");
	game = SceneManager.get_entity("Game");
	fire = SceneManager.get_entity("Fire");
	
	$RequirementsOverlay.hide();

func _process(delta):
	interact_available = game.has_resources(required_wood, required_stone, required_leaf);

func interact(_player):
	if disabled:
		return;
		
	if game.consume_resources(required_wood, required_stone, required_leaf):
		fire.increase_level();
		upgrade_count += 1;
		increase_next_resource_requirements();
	
		$AudioStreamPlayer.play();
		
		if fire.level >= 3:
			disable();

	else:
		print("not enough resources");

func increase_next_resource_requirements():
	required_wood += 2;
	required_stone += 1;


func disable():
	disabled = true;
	$SelfLight.energy = 0.3;
	_on_leave_range();
	

func _on_enter_range():
	$AnimatedSprite.animation = "active";
	$RequirementsOverlay.show();

func _on_leave_range():
	$AnimatedSprite.animation = "default";
	$RequirementsOverlay.hide();
