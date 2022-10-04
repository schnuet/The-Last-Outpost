extends Area2D

export var delay = 0;

var wood_item = preload("res://components/wood/Wood.tscn");
var stone_item = preload("res://components/stone/Stone.tscn");
var leaf_item = preload("res://components/leaf/Leaf.tscn");

var game;
var main_stage;

func _ready():
	yield(SceneManager, "scene_loaded");
	game = SceneManager.get_entity("Game");
	main_stage = SceneManager.get_entity("MainStage");
	$DelayTimer.start(delay + 0.2);

func spawn_resource():
	var item;
	
	var i = 0;
	while !item and i < 10:
		i += 1;
		
		var random_number = randi() % 20;
		
		if random_number <= 8:
			if game.wood >= 10:
				continue;
			item = wood_item;
		elif random_number <= 15:
			if game.stone >= 10:
				continue;
			item = stone_item;
		else:
			if game.stone >= 10:
				continue;
			item = leaf_item;
	
	if item == null:
		return;
	
	var pos = get_random_position();

	var spawned_item = item.instance();
	spawned_item.global_position = pos;
	
	main_stage.add_child(spawned_item);


func get_random_position():
	var width = int($CollisionShape2D.shape.extents.x) * 2;
	var height = int($CollisionShape2D.shape.extents.y) * 2;
	var x = randi() % width - width / 2;
	var y = randi() % height - height / 2;
	
	return to_global(Vector2(x, y));


func _on_Timer_timeout():
	spawn_resource();


func _on_DelayTimer_timeout():
	$Timer.start();
