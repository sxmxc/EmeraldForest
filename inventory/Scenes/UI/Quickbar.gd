extends "res://inventory/Scenes/UI/InventoryUI.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


const QUICKBAR_SLOT_SIZE = 12
var current_slot = 0
var prev_slot = 0

func _ready():
	self._initialize_slots()
	InventoryManager._register_inventory(self)
	InventoryManager.connect("inventory_updated", self, "_refresh_slots")
	for slot in slot_container.get_children():
		slot.connect("gui_input", self, "_slot_gui_input", [slot])
# Called when the node enters the scene tree for the first time.
func _initialize_slots():
	if !slot_ui_scene:
			slot_ui_scene = preload("res://inventory/Scenes/UI/InventorySlot.tscn")
	self.slot_container = $NinePatchRect/Margin/Grid
	self.slots = slot_container.get_children()
	for n in slots:
			slot_container.remove_child(n)
			n.queue_free()
	for n in QUICKBAR_SLOT_SIZE:
			var instance = slot_ui_scene.instance()
			slot_container.add_child(instance)
	slots = slot_container.get_children()
	var x = 0
	for i in QUICKBAR_SLOT_SIZE:
		if i < self.inventory.item_stacks.size():
			if slots[x]:
				slots[x]._add_item_to_slot(self.inventory.item_stacks[x])
		x += 1
	_refresh_slots()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _slot_gui_input(event: InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		if Global.debug:
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
	if !get_tree().paused:
		if event.is_action_pressed("quickbar_next"):
			prev_slot = current_slot
			current_slot = current_slot + 1 if current_slot + 1 < QUICKBAR_SLOT_SIZE else 0
		if event.is_action_pressed("quickbar_prev"):
			prev_slot = current_slot
			current_slot = current_slot - 1 if current_slot - 1 >= 0 else QUICKBAR_SLOT_SIZE -1
		slots[prev_slot].get_node("CenterContainer/Focus").visible = false
		slots[current_slot].get_node("CenterContainer/Focus").visible = true
	
func _refresh_slots():
	Print.line(Print.YELLOW, "Refreshing Quickbar")
	var x = 0
	for i in QUICKBAR_SLOT_SIZE:
		if i < self.inventory.item_stacks.size():
			if slots[x]:
				slots[x]._add_item_to_slot(self.inventory.item_stacks[x])
		x += 1
	for slot in self.slots:
		if !slot.slot_icon_ui:
			self_modulate = modulate.darkened(0.2)
		elif slot.slot_icon_ui:
			self_modulate = modulate.lightened(0.4)

#func _process(delta: float) -> void:
#	_refresh_style()

