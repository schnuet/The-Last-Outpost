extends Control

export var is_right = false;
export var max_value = 5 setget set_max_value;
export var value = 1 setget set_value;

var bar_3;
var bar_4;
var bar_5;
var bar_6;
var bar_8;
var bar_10;
var bar_12;
var bar_15;



var bars = {};

var current_bar;

var bar_widths = {
	"3": 63,
	"4": 84,
	"5": 100,
	"6": 123,
	"8": 159,
	"10": 200,
	"12": 236,
	"15": 294,
};

func _ready():
	bar_3 = $bar_3;
	bar_4 = $bar_4;
	bar_5 = $bar_5;
	bar_6 = $bar_6;
	bar_8 = $bar_8;
	bar_10 = $bar_10;
	bar_12 = $bar_12;
	bar_15 = $bar_15;
	bars = {
		"3": bar_3,
		"4": bar_4,
		"5": bar_5,
		"6": bar_6,
		"8": bar_8,
		"10": bar_10,
		"12": bar_12,
		"15": bar_15
	};
	current_bar = bar_3;
	
	set_max_value(max_value);
	set_value(value);

func set_value(val):
	if val > max_value:
		val = max_value;
		
	value = val;
	
	update_bar_blocks();

func set_max_value(val):
	max_value = val;

	update_bar();
	
	if value > max_value:
		set_value(max_value);
	
func update_bar():
	
	var old_max_value = max_value;
	
	var old_width = -1;
	
	if current_bar:
		old_width = bar_widths.get(str(old_max_value));
		current_bar.hide();
	
	if max_value == 3:
		current_bar = bars.get("3");
	elif max_value == 4:
		current_bar = bars.get("4");
	elif max_value == 5:
		current_bar = bars.get("5");
	elif max_value == 6:
		current_bar = bars.get("6");
	elif max_value == 8:
		current_bar = bars.get("8");
	elif max_value == 10:
		current_bar = bars.get("10");
	elif max_value == 12:
		current_bar = bars.get("12");
	elif max_value == 15:
		current_bar = bars.get("15");
	else:
		print(max_value, " not defined");
	
	var new_width = bar_widths.get(str(max_value));
	rect_min_size.x = new_width;
	rect_size.x = new_width;
	
	print("new_width: ", new_width);

	if is_right and old_width >= 0:
		rect_position.x -= new_width - old_width;
	
	current_bar.show();
	
	update_bar_blocks();
	
	

func update_bar_blocks():
	
	for i in max_value:
		var j = i + 1;
		if j <= value:
			current_bar.get_node(str(j)).show();
		elif current_bar.has_node(str(j)):
				current_bar.get_node(str(j)).hide();

