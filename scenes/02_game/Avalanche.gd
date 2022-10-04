extends AudioStreamPlayer


func _on_Timer_timeout():
	play();
	
	$Timer.start(randf() * 20 + 15);
