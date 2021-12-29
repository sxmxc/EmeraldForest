extends Control

export(Resource) var inventory
export(PackedScene) var slot_ui_scene
var holding_item = null

const slot_class = preload("res://inventory/Scenes/UI/InventorySlotUI.gd")

var slot_container
var slots

func _ready():
	_initialize_slots()
	$"/root/InventoryManager"._register_inventory(self)
	for slot in slot_container.get_children():
		slot.connect("gui_input", self, "_slot_gui_input", [slot])

func _slot_gui_input(event: InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		Print.line(Print.BLUE_BOLD, "Slot: " + slot.to_string() +" clicked on")
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.slot_icon_ui && !slot.locked:
					slot._put_into_slot(holding_item)
					holding_item = null
					$"/root/InventoryManager"._inventory_updated()
				elif !slot.locked:
					var temp = slot.slot_icon_ui
					slot._pick_from_slot()
					temp.global_position = event.global_position
					slot._put_into_slot(holding_item)
					holding_item = temp
					$"/root/InventoryManager"._inventory_updated()
			elif slot.slot_icon_ui && !slot.locked:
				holding_item = slot.slot_icon_ui
				slot._pick_from_slot()
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func _initialize_slots():
	slot_container = $NinePatchRect/MarginContainer/GridContainer
	if slot_container:
		slots = slot_container.get_children()
		if !slot_ui_scene:
			slot_ui_scene = preload("res://inventory/Scenes/UI/InventorySlot.tscn")
		for n in slots:
			slot_container.remove_child(n)
			n.queue_free()
		for n in inventory.max_inventory_size:
			var instance = slot_ui_scene.instance()
			if n > inventory.current_inventory_size - 1:
				instance.locked = true
			slot_container.add_child(instance)
		slots = slot_container.get_children()
		var x = 0
		for i in  inventory.item_stacks:
			slots[x]._add_item_to_slot(inventory.item_stacks[x])
			x += 1
	else:
		Print.line(Print.RED,"GDI something went wrong and slot container is null")
	$"/root/InventoryManager"._inventory_updated()
		


