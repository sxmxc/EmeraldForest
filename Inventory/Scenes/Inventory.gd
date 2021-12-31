extends Control

const slot_class = preload("res://Inventory/Scenes/Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	for slot in inventory_slots.get_children():
		slot.connect("gui_input", self, "_slot_gui_input", [slot])
		
func _slot_gui_input(event: InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			#holding item?
			if holding_item != null:
				#empty slot
				if !slot.item:
					slot._put_into_slot(holding_item)
					holding_item = null
				#something in slot
				else:
					#different item
					if holding_item.item_name != slot.item.item_name:
						var temp_item = slot.item
						slot._pick_from_slot()
						temp_item.global_position = event.global_position
						slot._put_into_slot(holding_item)
						holding_item = temp_item
					#same item, try and merge
					else:
						var stack_size = int(JsonImporter.item_data[slot.item.item_name]["StackSize"])
						var stack_capacity = stack_size - slot.item.item_quantity
						if stack_capacity >= holding_item.item_quantity:
							slot.item._add_item_quantity(holding_item.item_quantity)
							holding_item.queue_free()
							holding_item = null
						else:
							slot.item._add_item_quantity(stack_capacity)
							holding_item._decrease_item_quantity(stack_capacity)
			#we aint holding shit
			elif slot.item:
				holding_item = slot.item 
				slot._pick_from_slot()
				holding_item.global_position = get_global_mouse_position()
				
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
