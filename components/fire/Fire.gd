class_name Fire
extends StaticBody2D

signal health_decrease(new_health)

var health = 10 setget set_health;
var max_health = 10 setget set_max_health;

export var level = 1;
var disabled = false;
var interact_available = false;

var required_wood = 1;
var required_stone = 0;
var required_leaf = 0;

var base_light_energy = 1;
var target_light_energy = base_light_energy;
var extra_energy = 0;

onready var fire_sprite = $Images/AnimatedSprite;
onready var fire_light = $Light2D;
onready var flicker_timer = $FlickerTimer;
onready var fire_energy_tween = $LightEnergyTween;
onready var no_danger_icon = preload("res://assets/icons/icon_fire.png");
onready var danger_icon = preload("res://assets/icons/icon_fire_red.png");


var game;
var fire_bar;
var icon;
var player;

func _ready():
	yield(SceneManager, "scene_loaded");
	game = SceneManager.get_entity("Game");
	fire_bar = SceneManager.get_entity("FireBar");
	icon = SceneManager.get_entity("FireIcon");
	player = SceneManager.get_entity("Player");
	
	set_level(1);
	set_max_health(6);
	set_health(max_health);
	
	$RequirementsOverlay.hide();


func _process(delta):
	interact_available = game.has_resources(required_wood, required_stone, required_leaf);
	

func set_health(value):
	health = value;
	fire_bar.value = value;

	if health <= 0:
		Globals.set("game_over_reason", "fire");
		Globals.set("game_ready", false);
		SceneManager.change_scene("res://scenes/03_game_over/SceneGameOver.tscn");
	
	if health <= max_health * 0.4:
		fire_sprite.animation = "low";
		base_light_energy = 0.6;
		icon.texture = danger_icon;
		icon.get_node("AnimationPlayer").play("Blink");
	
	elif health <= max_health * 0.75:
		fire_sprite.animation = "middle";
		base_light_energy = 0.8;
		icon.texture = no_danger_icon;
		icon.get_node("AnimationPlayer").stop(true);
	
	else:
		fire_sprite.animation = "high";
		base_light_energy = 1;
		icon.texture = no_danger_icon;
		icon.get_node("AnimationPlayer").stop(true);

func set_max_health(value):
	max_health = value;
	fire_bar.max_value = value;
	

func interact(_player: KinematicBody2D):
	if health >= max_health:
		print("barrier not damaged.");
		return;
	
	if game.consume_resources(required_wood, required_stone, required_leaf):
		increase_health(1);
		$AddSound.play();
		print("fire health restore ", health);
	else:
		print("not enough resources");

func increase_health(value: int):
	set_health(health + value);
	print("fire health increased to ", health);
	
	if health > max_health:
		health = max_health;

func decrease_health(value: int):
	set_health(health - value);
	print("fire health decreased to ", health);
	
	emit_signal("health_decrease", health);
	

func increase_level():
	var lost_health = max_health - health;
	
	set_level(level + 1);
	
	set_health(max_health - lost_health);
	
	print("fire level increased to ", level);

func set_level(val):
	level = val;
	
	if level == 2:
		set_max_health(7);
	if level == 3:
		set_max_health(8);
	
	if level == 2:
		$Images/FireBase2.show();
	
	elif level == 3:
		$Images/FireBase3.show();

func _on_Timer_timeout():
	decrease_health(1);


func _on_enter_range():
	extra_energy = 0.5;
	player.set_health(player.max_health);
	$RequirementsOverlay.show();

func _on_leave_range():
	extra_energy = 0;
	$RequirementsOverlay.hide();


func _on_AnimatedSpriteTimer_timeout():
	$Images/AnimatedSprite.flip_h = !$Images/AnimatedSprite.flip_h


func set_light_energy(value):
	fire_energy_tween.stop_all();
	fire_energy_tween.remove_all();
	fire_energy_tween.interpolate_property(fire_light, "energy", fire_light.energy, value, 0.2);
	fire_energy_tween.start();

func _on_FlickerTimer_timeout():
	var flicker_energy = 0.4;
	set_light_energy(base_light_energy + extra_energy + randf() * flicker_energy - flicker_energy/2);
