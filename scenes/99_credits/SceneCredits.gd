extends "../Scene.gd";


func _on_BackButton_pressed():
	SceneManager.change_scene("res://scenes/01_start/SceneStart.tscn");


func _on_CreditsScene_hidden():
	$CanvasLayer.hide();


func _on_CreditsScene_shown():
	$CanvasLayer.show();
