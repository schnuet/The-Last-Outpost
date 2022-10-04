extends Node2D

var required_wood = -1;
var required_stone = -1;
var required_leaf = -1;

var generally_visible = false;

func _ready():
	generally_visible = visible;
	if generally_visible:
		show();
	else:
		hide();

func show():
	generally_visible = true;
	.show();

func hide():
	generally_visible = false;
	.hide();

func _process(_delta):
	var parent = get_parent();
	
	if not generally_visible:
		return;
	
	if not parent.interact_available:
		modulate = Color(1, 1, 1, 0.8);
	elif parent.interact_available:
		modulate = Color(1, 1, 1, 1);
	
	if parent.required_wood != required_wood:
		if required_wood <= 0:
			$Graphic/Lines/WoodLine.show();
			
		required_wood = parent.required_wood;
		
		$Graphic/Lines/WoodLine/WoodLabel.text = str(required_wood);
		
		if required_wood <= 0:
			$Graphic/Lines/WoodLine.hide();
	
	if parent.required_stone != required_stone:
		if required_stone <= 0:
			$Graphic/Lines/StoneLine.show();
			
		required_stone = parent.required_stone;
		
		$Graphic/Lines/StoneLine/StoneLabel.text = str(required_stone);
		
		if required_stone <= 0:
			$Graphic/Lines/StoneLine.hide();
	
	if parent.required_leaf != required_leaf:
		if required_leaf <= 0:
			$Graphic/Lines/LeafLine.show();
			
		required_leaf = parent.required_leaf;
		
		$Graphic/Lines/LeafLine/LeafLabel.text = str(required_leaf);
		
		if required_leaf <= 0:
			$Graphic/Lines/LeafLine.hide();
	
