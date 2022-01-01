extends Node

signal active_item_updated
signal inventory_updated

const slot_class = preload("res://Inventory/Scripts/Slot.gd")
const item_class = preload("res://Inventory/Scripts/Item.gd")
const NUM_INVENTORY_SLOTS = 32
const NUM_QUICKBAR_SLOTS = 12

var slots = []
var qb_slots = []

var current_active_slot = 0

var inventory = {
	0: ["Copper Pickaxe", 1],
	1: ["Copper Axe", 1],
	2: ["Copper Ore", 97],
	3: ["Watering Can", 1],
	4: ["Seed Pack", 97]
#--> slot_index: [item_name, quantity]
}


func _ready():
	pass

func _add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(ItemImporter.item_data[item_name]["StackSize"])
			var stack_capacity = stack_size - inventory[item][1]
			if stack_capacity >= item_quantity:
				inventory[item][1] += item_quantity
				_update_slot_visual(item, inventory[item][0], inventory[item][1])
				emit_signal('inventory_updated')
				return
			else:
				inventory[item][1] += stack_capacity
				_update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - stack_capacity
				emit_signal('inventory_updated')

	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			_update_slot_visual(i, inventory[i][0], inventory[i][1])
			emit_signal('inventory_updated')
			return

func _register_slot(slot :slot_class):
	slots.insert(slot.slot_idx,slot)

func _register_quickbar_slot(slot :slot_class):
	qb_slots.insert(slot.slot_idx,slot)

func _add_item_to_empty_slot(item: item_class, slot: slot_class):
	inventory[slot.slot_idx] = [item.item_name, item.item_quantity]
	emit_signal('inventory_updated')

func _remove_item(slot: slot_class):
	inventory.erase(slot.slot_idx)
	emit_signal('inventory_updated')

func _add_item_quantity(slot: slot_class, quantity_to_add):
	inventory[slot.slot_idx][1] += quantity_to_add
	emit_signal('inventory_updated')

func _update_slot_visual(slot_index,item_name, item_quantity ):
	var slot = slots[slot_index]
	if slot.item != null:
		slot.item._set_item(item_name, item_quantity)
	else:
		slot._initialize_item(item_name, item_quantity)
func _use_active_item(tm, ft):
	if(slots[current_active_slot].item != null):
		slots[current_active_slot].item._use_item(tm, ft)
func _active_item_scroll_up():
	current_active_slot = (current_active_slot + 1) % NUM_QUICKBAR_SLOTS
	emit_signal("active_item_updated")

func _active_item_scroll_down():
	current_active_slot = NUM_QUICKBAR_SLOTS - 1 if current_active_slot == 0 else current_active_slot - 1
	emit_signal("active_item_updated")
