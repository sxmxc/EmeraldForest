extends Node2D

class_name Item

var item_name
var item_quantity

func _ready():
	pass
		
func _add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func _decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
	
func _use_item(tile_map,target_tile):
	pass
			
func _set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://Images/Assets/SpriteSheets/Chopped/" \
	+ ItemImporter.item_data[item_name]["Texture"])

	var stack_size = int(ItemImporter.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)
	
