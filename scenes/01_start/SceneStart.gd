extends "../Scene.gd";


func _ready():
	$StartButton.visible = false;
	$CreditsButton.visible = false;
	
	$Floor/LastOutpostFireHigh/AnimationPlayer.play("flicker");
	$Floor/AnimationPlayer.play("rise");
	
	MusicPlayer.play_music("maintheme");


func _unhandled_input(event):
	if event.is_action("action"):
		_on_StartButton_pressed();


func _on_StartButton_pressed():
	Globals.set("game_ready", false);
	SceneManager.change_scene("res://scenes/05_tutorial/TutorialScene.tscn");


func _on_CreditsButton_pressed():
	SceneManager.change_scene("res://scenes/99_credits/SceneCredits.tscn");


func _on_StartScene_hidden():
	$CanvasLayer.hide();


func _on_StartScene_shown():
	$CanvasLayer.show();


func _on_SettingsButton_pressed():
	MenuPopup.show();


func _on_ButtonsTimer_timeout():
	$StartButton/AnimationPlayer.play("in");
	$CreditsButton/AnimationPlayer.play("in");
	
	$ButtonsTimer/VisibilityTimer.start(0.1);


func _on_VisibilityTimer_timeout():
	$StartButton.visible = true;
	$CreditsButton.visible = true;
