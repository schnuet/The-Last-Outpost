extends Area2D

export var delay = 0;

var wood_item = preload("res://components/wood/Wood.tscn");
var stone_item = preload("res://components/stone/Stone.tscn");
var leaf_item = preload("res://components/leaf/Leaf.tscn");

var main_stage;

func _ready():
	yield(SceneManager, "scene_loaded");
	main_stage = SceneManager.get_entity("MainStage");
	$DelayTimer.start(delay + 0.2);

func spawn_resource():
	var random_number = randi() % 20;
	
	var item;
	
	if random_number <= 8:
		item = wood_item;
	elif random_number <= 15:
		item = stone_item;
	else:
		item = leaf_item;
	
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
