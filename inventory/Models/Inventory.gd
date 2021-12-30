extends Resource
class_name Inventory


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var inventory_name
export(Array, Resource) var item_stacks
export(int) var max_inventory_size
export(int) var current_inventory_size = 12
export(ItemType.Type) var item_type


var item_stack_res = preload("res://inventory/Models/ItemStack.gd")
var item_database

signal item_added
signal item_removed
# Called when the node enters the scene tree for the first time.

func _add_item(id: int, quantity = 1):
	var exists = false
	for i in item_stacks:
		if i.item.item_id == id:
			i.quantity += quantity
			exists = true
			return	
	item_stacks.append()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
