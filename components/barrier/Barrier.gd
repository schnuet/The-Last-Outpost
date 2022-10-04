class_name Barrier
extends StaticBody2D

var required_wood = 1;
var required_stone = 1;
var required_leaf = 0;

var health = 10 setget set_health;
var max_health = 10 setget set_max_health;

var level = 1;
var disabled = false;
var interact_available = false;

onready var animated_sprite = $AnimatedSprite;

# scene manager entities
onready var game;
onready var icon;
onready var bar;
onready var background;

var status = 3;

onready var no_danger_icon = preload("res://assets/icons/icon_wall.png");
onready var danger_icon = preload("res://assets/icons/icon_wall_red.png");

func _ready():
	yield(SceneManager, "scene_loaded");
	
	game = SceneManager.get_entity("Game");
	icon = SceneManager.get_entity("BarrierIcon");
	bar = SceneManager.get_entity("BarrierBar");
	background = SceneManager.get_entity("BarrierBackground");
	
	$RequirementsOverlay.hide();
	
	set_max_health(10);
	set_health(max_health);

func _process(_delta):
	interact_available = game.has_resources(required_wood, required_stone, required_leaf);

func set_max_health(value):
	max_health = value;
	bar.max_value = max_health;

func set_health(value):
	var state_before = get_state();
	var health_before = health;
	health = value;
	bar.value = health;
	
	update_sprite();
	
	if health <= 0:
		Globals.set("game_over_reason", "barrier");
		Globals.set("game_ready", false);
		SceneManager.change_scene("res://scenes/03_game_over/SceneGameOver.tscn");
	
	if health <= 3:
		icon.texture = danger_icon;
		icon.get_node("AnimationPlayer").play("Blink");
	else:
		icon.texture = no_danger_icon;
		icon.get_node("AnimationPlayer").stop();
	
	# play destruction sound on layer change
	if health_before > health and state_before != get_state():
		$DestroySound.play();

func interact(_player):
	if health >= max_health:
		print("barrier not damaged.");
		return;
	
	if game.consume_resources(required_wood, required_stone, required_leaf):
		$RepairSound.play(0);
		set_health(health + 1);
		print("barrier repaired");
	else:
		print("not enough resources to repair barrier");


func receive_damage():
	set_health(health - 1);
	print("barrier received damage: ", health);

func increase_level():
	if level == 3:
		return;
	
	var lost_health = max_health - health;
	level += 1;
	
	if level == 2:
		set_max_health(12);
	
	if level == 3:
		set_max_health(15);
		
	set_health(max_health - lost_health);
	print("barrier level increased: ", level);


func get_state():
	if health <= 3:
		return "bad";
	if health <= 7:
		return "middle";
	else:
		return "good";

func update_sprite():
	background.animation = "lvl-" + str(level) + "-" + str(get_state());

func _on_Timer_timeout():
	receive_damage();


func _on_enter_range():
	animated_sprite.animation = "active";
	$RequirementsOverlay.show();

func _on_leave_range():
	animated_sprite.animation = "default";
	$RequirementsOverlay.hide();
