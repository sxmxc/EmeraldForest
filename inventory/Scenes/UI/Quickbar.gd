extends "res://inventory/Scenes/UI/InventoryUI.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


const QUICKBAR_SLOT_SIZE = 12
var current_slot = 0
var prev_slot = 0


func _ready():
	self._initialize_slots()
	$"/root/InventoryManager"._register_inventory(self)
	$"/root/InventoryManager".connect("inventory_updated", self, "_refresh_style")
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("quickbar_next"):
		prev_slot = current_slot
		current_slot = current_slot + 1 if current_slot + 1 < QUICKBAR_SLOT_SIZE else 0
	if event.is_action_pressed("quickbar_prev"):
		prev_slot = current_slot
		current_slot = current_slot - 1 if current_slot - 1 >= 0 else QUICKBAR_SLOT_SIZE -1
	slots[prev_slot].get_node("CenterContainer/Focus").visible = false
	slots[current_slot].get_node("CenterContainer/Focus").visible = true
	
func _refresh_style():
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

func _pick_from_slot():
	$CenterContainer.remove_child(self.slot_icon_ui)
	var inventory_node = find_parent("Quickbar")
	inventory_node.add_child(self.slot_icon_ui)
	self.slot_icon_ui = null
	_refresh_style()
#	var inventory_manager = find_parent("InventoryManager")

func _put_into_slot(slot_icon):
	self.slot_icon_ui = slot_icon
	self.slot_icon_ui.position = Vector2(0,0)
	var inventory_node= find_parent("Quickbar")
	inventory_node.remove_child("slot_icon_ui")
	$CenterContainer.add_child(self.slot_icon_ui)
	self.slot_icon_ui.set_owner($CenterContainer)
	_refresh_style()
