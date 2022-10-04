# MessageBox
#
# This box can be used to show a simple dialog line with a character image.
#
# |------|   This is the text of the character.
# |  :)  |
# |------|
# 
# Usage:
# yield(MessageBox.show_message("mom", "Hello son!", "happy"), "done");

extends CanvasLayer

# This signal is emitted by the MessageBox as soon as the message is hidden.
# It can be used to wait on the message, using yield().
signal done

enum States {
	IDLE,
	WRITING,
	WAITING
};
var state = States.IDLE;
var can_skip = true;

# flags for input handling
var action_pressed = false;
var animation_finished = false;

func _ready():
	hide();
	$Control/Label.percent_visible = 0;
	$Control/Label.hide();
	var _visible_signal = $Control/Tween.connect("tween_all_completed", self, "message_fully_visible");
	var _done_signal = $Control/Timer.connect("timeout", self, "show_message_done");


func show_message(character_name:String, text:String, emotion:String = "neutral", skippable:bool = true):
	# show a message on the screen.
	
	# Reset everything:
	$Control/Tween.stop_all();
	$Control/Timer.stop();
	$Control/Label.percent_visible = 0;
	
	$Control/Head.animation = character_name + "-" + emotion;
	$Control/Label.text = text;
	
	print(character_name, ":", text);
	
	state = States.WRITING;
	
	can_skip = skippable;
	
	show();
	$Control/SpeechBubble.frame = 0;
	$Control/SpeechBubble.show();
	$Control/SpeechBubble.play();
	$Control/Head.show();
	$Control/Head.play();
	animation_finished = false;
	
	# return self for yielding the done event (important for chaining)
	return self

func _on_SpeechBubble_animation_finished():
	# start writing the text
	$Control/Label.show();
	$Control/Tween.interpolate_property($Control/Label, "percent_visible", 0, 1, $Control/Label.text.length() * 0.02, Tween.TRANS_LINEAR, Tween.EASE_IN, 0);
	$Control/Tween.start();
	animation_finished = true;
	

func message_fully_visible():
	$Control/Timer.start(3);
	state = States.WAITING;

func show_message_done():
	# Activated by Control/Timer 3 seconds after the message was fully shown
	
	# Hide everything again.
	$Control/SpeechBubble.hide();
	$Control/Head.hide();
	$Control/Label.hide();
	$Control/Label.percent_visible = 0;
	state = States.IDLE;
	hide();

func _input(_event):
	if animation_finished == false:
		return;

	if not can_skip:
		return;
		
	if state == States.IDLE:
		return
	
	if Input.is_action_just_pressed("action"):
		action_pressed = true
	if action_pressed and Input.is_action_just_released("action"):
		action_pressed = false;
		if state == States.WRITING:
			$Control/Tween.remove_all();
			$Control/Tween.stop_all();
			$Control/Label.percent_visible = 1;
			message_fully_visible();
		if state == States.WAITING:
			$Control/Timer.stop();
			show_message_done();
			


func _on_MessageBox_visibility_changed():
	# if the messagebox is hidden, emit a "done" signal
	# to resolve any scripts that wait for the message to be done.
	if not visible:
		emit_signal("done");
