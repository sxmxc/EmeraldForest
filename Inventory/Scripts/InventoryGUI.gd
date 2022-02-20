extends Control
class_name InventoryGUI

const slot_class = preload("res://Inventory/Scripts/Slot.gd")
const item_class = preload("res://Inventory/Scripts/Item.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	var e = Global.connect("player_menu_requested", self, "_initialize_inventory")
	if(e):
		Print.line(Print.RED,str(e))
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(_slot_gui_input,[slots[i]])
		slots[i].slot_idx = i
		slots[i].slot_type = slot_class.SlotType.BACKPACK
		PlayerInventory._register_slot(slots[i])
	_initialize_inventory()
		
func _slot_gui_input(event: InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			#holding item?
			if holding_item != null:
				if !slot.item:
				#empty slot
					_left_click_empty_slot(slot)
				
				else:
				#something in slot
					#different item
					if holding_item.item_name != slot.item.item_name:
						_left_click_dif_item(slot,event)
					else:
					#same item, try and merge
						_left_click_same_item(slot)
			elif slot.item:
			#we aint holding shit
				_left_click_no_item(slot)
				
func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func _initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i]._initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func _left_click_empty_slot(slot: slot_class):
	PlayerInventory._add_item_to_empty_slot(holding_item,slot)
	slot._put_into_slot(holding_item)
	holding_item = null

func _left_click_dif_item(slot: slot_class, event: InputEvent):
	PlayerInventory._remove_item(slot)
	PlayerInventory._add_item_to_empty_slot(holding_item,slot)
	var temp_item = slot.item
	slot._pick_from_slot()
	temp_item.global_position = event.global_position
	slot._put_into_slot(holding_item)
	holding_item = temp_item

func _left_click_same_item(slot: slot_class):
	var stack_size = int(ItemImporter.item_data[slot.item.item_name]["StackSize"])
	var stack_capacity = stack_size - slot.item.item_quantity
	if stack_capacity >= holding_item.item_quantity:
		PlayerInventory._add_item_quantity(slot, holding_item.item_quantity)
		slot.item._add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
	else:
		PlayerInventory._add_item_quantity(slot, stack_capacity)
		slot.item._add_item_quantity(stack_capacity)
		holding_item._decrease_item_quantity(stack_capacity)

func _left_click_no_item(slot):
	PlayerInventory._remove_item(slot)
	holding_item = slot.item 
	slot._pick_from_slot()
	holding_item.global_position = get_global_mouse_position()
