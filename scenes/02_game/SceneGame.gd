class_name Game
extends "../Scene.gd";

const primary_color = "#FF7532";

# resource values
var wood = 3 setget set_wood;
var stone = 1 setget set_stone;
var leaf = 0 setget set_leaf;

var wood_count_label;
var stone_count_label;
var leaf_count_label;

func _ready():
	Globals.set("game_over_reason", "none");
	
	var stopwatch = StopWatch.new();
	Globals.set("stopwatch", stopwatch);
	stopwatch.start();
	
	
	yield(SceneManager, "scene_loaded");
	Globals.set("game_ready", true);
	wood_count_label = SceneManager.get_entity("WoodCountLabel");
	stone_count_label = SceneManager.get_entity("StoneCountLabel");
	leaf_count_label = SceneManager.get_entity("LeafCountLabel");
	
	$SnowParticles.emitting = true;
	MusicPlayer.play_music("maintheme");
	
	# update labels
	set_wood(wood);
	set_stone(stone);
	set_leaf(leaf);
	

func has_resources(w, s = 0, l = 0):
	return wood >= w && stone >= s && leaf >= l;

func consume_resources(w, s, l):
	if not has_resources(w, s, l):
		return false;
	
	set_wood(wood - w);
	set_stone(stone - s);
	set_leaf(leaf - l);
	
	return true;

func set_wood(value):
	wood = value;
	var wood_label = wood_count_label;
	wood_label.text = str(value);
	if value >= 10:
		wood_label.set("custom_colors/font_color", Color(primary_color));
	else:
		wood_label.set("custom_colors/font_color", Color.black);


func set_stone(value):
	stone = value;
	stone_count_label.text = str(value);
	
	
func set_leaf(value):
	leaf = value;
	leaf_count_label.text = str(value);


func add_wood(value):
	set_wood(wood + value);

func add_stone(value):
	set_stone(stone + value);

func add_leaf(value):
	set_leaf(leaf + value);
	
