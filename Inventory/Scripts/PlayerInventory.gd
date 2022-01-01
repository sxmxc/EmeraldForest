extends Node

const slot_class = preload("res://Inventory/Scripts/Slot.gd")
const item_class = preload("res://Inventory/Scripts/Item.gd")
const NUM_INVENTORY_SLOTS = 32

var inventory = {
	0: ["Copper Pickaxe", 1],
	1: ["Copper Axe", 1],
	2: ["Copper Ore", 97]
#--> slot_index: [item_name, quantity]
}


func _ready():
	pass

func _add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonImporter.item_data[item_name]["StackSize"])
			var stack_capacity = stack_size - inventory[item][1]
			if stack_capacity >= int(item_quantity):
				inventory[item][1] += item_quantity
				return
			else:
				inventory[item][1] += stack_capacity
				item_quantity = item_quantity - stack_capacity

	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return

func _add_item_to_empty_slot(item: item_class, slot: slot_class):
	inventory[slot.slot_idx] = [item.item_name, item.item_quantity]

func _remove_item(slot: slot_class):
	inventory.erase(slot.slot_idx)

func _add_item_quantity(slot: slot_class, quantity_to_add):
	inventory[slot.slot_idx][1] += quantity_to_add