extends Node2D

var page = 1;
var min_page = 1;
var max_page = 4;

func _unhandled_input(event):
	if event.is_action_released("action"):
		if page < max_page:
			_on_ButtonNext_pressed();
		else:
			_on_ButtonStart_pressed();

func _ready():
	if max_page > 1:
		$ButtonNext.show();


func _on_ButtonPrevious_pressed():
	if page <= min_page:
		return;
	
	hide_page(page);
	show_page(page - 1);
	
	page -= 1;
	$ButtonNext.show();
	
	if page <= min_page:
		$ButtonPrevious.hide();
	

func _on_ButtonNext_pressed():
	if page >= max_page:
		return;
	
	hide_page(page);
	show_page(page + 1);
	
	page += 1;
	$ButtonPrevious.show();
	
	if page >= max_page:
		$ButtonNext.hide();
		$ButtonStart.show();
		$ButtonSkip.hide();

func show_page(p):
	var p_node = get_node("Screen" + str(p));
	p_node.show();


func hide_page(p):
	var p_node = get_node("Screen" + str(p));
	p_node.hide();

func _on_ButtonStart_pressed():
	_on_ButtonSkip_pressed();
	

func _on_ButtonSkip_pressed():
	SceneManager.change_scene("res://scenes/02_game/SceneGame.tscn");

