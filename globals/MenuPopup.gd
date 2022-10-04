extends CanvasLayer

func _on_CloseButton_pressed():
	hide()

func _on_AudioVolumeSlider_drag_ended(value_changed):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value_changed);

func _on_MenuPopup_popup_hide():
	hide()
	
func show():
	.show();
	$MenuPopup.popup();

func _input(event):
	if event.is_action("settings"):
		if visible:
			hide();
		else:
			show();


func _on_AudioVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value);
