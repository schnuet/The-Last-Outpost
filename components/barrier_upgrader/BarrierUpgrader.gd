extends StaticBody2D

var required_wood = 2;
var required_stone = 2;
var required_leaf = 0;

var upgrade_count = 0;

var disabled = false;
var interact_available = false;

onready var game;
onready var barrier;

func _ready():
	yield(SceneManager, "scene_loaded");
	
	game = SceneManager.get_entity("Game");
	barrier = SceneManager.get_entity("Wall");
	
	$RequirementsOverlay.hide();

func _process(_delta):
	interact_available = game.has_resources(required_wood, required_stone, required_leaf);

func interact(_player):
	if disabled:
		return;
	
	if game.consume_resources(required_wood, required_stone, required_leaf):
		barrier.increase_level();
		upgrade_count += 1;
		increase_next_resource_requirements();
		
		$AudioStreamPlayer.play(0);
		
		if barrier.level >= 3:
			disable();
	else:
		print("not enough resources");


func increase_next_resource_requirements():
	required_wood += 2; # required_wood;
	required_stone += 1; # required_stone;


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
