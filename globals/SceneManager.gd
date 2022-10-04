extends Node2D

var current_scene = null;

onready var scenes = $Scenes.get_children();

signal scene_entered;
signal scene_left;

func _ready():
	make_scenes_inactive();

## Replace the current scene with another.
## Scenes must be registered in the SceneManager.
func change_scene(scene_name:String, _player_position:Vector2 = Vector2.ZERO):
	if current_scene:
		deactivate_scene(current_scene);
	
#	if player_position != Vector2.ZERO:
#		player.global_position = player_position;
	
	var scene = get_node("Scenes/" + scene_name);
	
	if scene == null:
		push_error("The scene '" + scene_name + "' is not registered in SceneManager.");
		return;
	
	activate_scene(scene);
	current_scene = scene;
	print("change scene to ", scene.name);

func activate_scene(scene:Scene):
	scene.set_position(Vector2.ZERO);
	scene.set_process(false);
	scene.set_physics_process(false);
	scene.show();
	scene.emit_signal("shown");
	print("activated scene ", scene);
	emit_signal("scene_entered", scene);

func deactivate_scene(scene:Scene):
	scene.set_position(Vector2(50000, 10000));
	scene.set_process(false);
	scene.set_physics_process(false);
	scene.hide();
	scene.emit_signal("hidden");
	print("deactivated scene ", scene);
	emit_signal("scene_left", scene);

func make_scenes_inactive():
	for scene in scenes:
		deactivate_scene(scene);
