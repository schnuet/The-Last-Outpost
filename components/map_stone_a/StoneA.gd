extends StaticBody2D


func _on_VisibilityArea_body_exited(_body):
	$Stone.self_modulate = Color(1, 1, 1, 1);


func _on_Area2D_body_entered(_body):
	$Stone.self_modulate = Color(1, 1, 1, 0.5);
