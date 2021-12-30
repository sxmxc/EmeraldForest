extends Control

class_name InventoryUI

export(Resource) var inventory
export(PackedScene) var slot_ui_scene
var slot_list = []
var holding_item = null

onready var tooltip = $NinePatchRect/ToolTip
onready var ferry = $NinePatchRect/InventoryFerry

const item_class = preload("res://inventory/Models/Item.gd")
const item_stack_class = preload("res://inventory/Models/ItemStack.gd")
const slot_class = preload("res://inventory/Scenes/UI/InventorySlotUI.gd")

var slot_container
var slots

func _ready():
	_initialize_slots()

func _slot_gui_input(event: InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		Print.line(Print.BLUE_BOLD, "Slot: " + slot.to_string() +" clicked on")
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.slot_icon_ui && !slot.locked:
					ferry.remove_child(holding_item)
					slot._put_into_slot(holding_item)
					holding_item = null
					InventoryManager._inventory_updated()
					_refresh_slots()
				elif !slot.locked:
					var temp = slot.slot_icon_ui
					slot._pick_from_slot()
					ferry.add_child(temp)
					temp.global_position = event.global_position
					ferry.remove_child(holding_item)
					slot._put_into_slot(holding_item)
			
					holding_item = temp
					InventoryManager._inventory_updated()
					_refresh_slots()
			elif slot.slot_icon_ui && !slot.locked:
				holding_item = slot.slot_icon_ui
				slot._pick_from_slot()
				ferry.add_child(holding_item)
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func _initialize_slots():
	slot_container = $NinePatchRect/Margin/Grid
	
	if slot_container:
		slots = slot_container.get_children()
		if !slot_ui_scene:
			slot_ui_scene = preload("res://inventory/Scenes/UI/InventorySlot.tscn")
		for n in slots:
			slot_container.remove_child(n)
			n.queue_free()
		for n in inventory.max_inventory_size:
			var slot = slot_ui_scene.instance()
			if n >= inventory.current_inventory_size:
				slot.locked = true
			slot.connect("gui_input", self, "_slot_gui_input", [slot])
			slot.connect("mouse_entered", self, "mouse_enter_slot", [slot]);
			slot.connect("mouse_exited", self, "mouse_exit_slot", [slot]);
			slot.slot_idx = n - 1
			slot_list.append(slot)
			slot_container.add_child(slot)
			
		slots = slot_container.get_children()
		var x = 0
		for i in  inventory.item_stacks:
			slots[x]._add_item_to_slot(inventory.item_stacks[x])
			x += 1
	else:
		Print.line(Print.RED,"GDI something went wrong and slot container is null")
	InventoryManager._inventory_updated()
	_refresh_slots()	

func mouse_enter_slot(_slot : slot_class):
	if _slot.slot_icon_ui:
		tooltip.display(_slot.slot_icon_ui.current_item_stack, get_global_mouse_position());

func mouse_exit_slot(_slot : slot_class):
	if tooltip.visible:
		tooltip.hide();
		
func _refresh_slots():
	if slots:
		for slot in slots:
			if !slot.slot_icon_ui && !slot.locked:
				self_modulate = modulate.darkened(0.2)
			if slot.locked && !slot.slot_icon_ui:
				self_modulate = modulate.darkened(0.4)
			elif slot.slot_icon_ui:
				self_modulate = modulate.lightened(0.4)
