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

signal item_added
signal item_removed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
