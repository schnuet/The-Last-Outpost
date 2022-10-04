extends Scene

func _ready():
	var reason_label = $CanvasLayer/CenterContainer/GameOverReason;
	var tip_label = $CanvasLayer/CenterContainer2/GameOverTip;
	var time_label = $CanvasLayer/CenterContainer3/SurvivalTimeString;
	
	# write text
	var stop_watch = Globals.get("stopwatch");
	var game_minutes = 0;
	var game_seconds = 0;
	if stop_watch:
		stop_watch.stop();
		game_seconds = stop_watch.get_elapsed_msec() / 1000;
		game_minutes = floor(game_seconds / 60.0);
		game_seconds = round(game_seconds - game_minutes * 60);
	time_label.text = "you survived " + str(game_minutes) + " minutes and " + str(game_seconds) + " seconds.";
	
	
	var game_over_reason = Globals.get("game_over_reason");
	
	
	if game_over_reason == "cold":
		reason_label.text = "You died in the cold winds of winter.";
		tip_label.text = "Stay close to the fire to regain warmth.";

	elif game_over_reason == "barrier":
		reason_label.text = "After several attempts, the last barrier was finally destroyed.";
		tip_label.text = "You can repair the barrier with wood and stone.";
	
	elif game_over_reason == "fire":
		reason_label.text = "The last flame finally went out. Darkness overruns the lands.";
		tip_label.text = "Collect as much wood as possible.";
	

func _on_RestartButton_pressed():
	Globals.set("game_ready", false);
	SceneManager.change_scene("res://scenes/02_game/SceneGame.tscn");


func _on_CreditsButton_pressed():
	SceneManager.change_scene("res://scenes/01_start/SceneStart.tscn");
