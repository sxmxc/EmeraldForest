extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Copper Pickaxe"
	elif rand_val == 2:
		item_name = "Copper Axe"
	else:
		item_name = "Copper Ore"
		
	$TextureRect.texture = load("res://Images/Assets/SpriteSheets/Chopped/" \
	+ JsonImporter.item_data[item_name]["Texture"])
	var stack_size = int(JsonImporter.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)
		
func _add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func _decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)

