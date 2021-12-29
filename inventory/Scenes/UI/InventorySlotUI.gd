extends Panel
class_name InventorySlotUI

var slot_icon_ui


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const slot_icon_ui_scene = preload("res://inventory/Scenes/UI/SlotItemIconUI.tscn")

export(bool) var locked
	

	
# Called when the node enters the scene tree for the first time.
func _ready():
	self._refresh_style()
	$"/root/InventoryManager".connect("inventory_updated", self, "_refresh_style")
	
func _setup_slot():
	if not $CenterContainer.has_node("SlotItemIconUI"):
		_add_item_ui_icon()
	else:
		slot_icon_ui = $CenterContainer/SlotItemIconUI
	_refresh_style()
		
func _refresh_style():
	if !self.slot_icon_ui && !self.locked:
		self_modulate = modulate.darkened(0.2)
	if self.locked && !self.slot_icon_ui:
		self_modulate = modulate.darkened(0.4)
	elif self.slot_icon_ui:
		self_modulate = modulate.lightened(0.4)

#func _process(delta: float) -> void:
#	_refresh_style()

func _pick_from_slot():
	$CenterContainer.remove_child(slot_icon_ui)
	var inventory_node = InventoryManager
	inventory_node.add_child(slot_icon_ui)
	slot_icon_ui = null
	_refresh_style()
#	var inventory_manager = find_parent("InventoryManager")

func _put_into_slot(slot_icon):
	if !locked:
		slot_icon_ui = slot_icon
		slot_icon_ui.position = Vector2(0,0)
		var inventory_node = InventoryManager
		inventory_node.remove_child(slot_icon_ui)
		$CenterContainer.add_child(slot_icon_ui)
		slot_icon_ui.set_owner($CenterContainer)
		_refresh_style()
	
	
func _add_item_to_slot(item_stack):
	_setup_slot()
	slot_icon_ui.current_item_stack = item_stack
	slot_icon_ui.item_icon.texture = item_stack.item.item_icon
	slot_icon_ui.quantity.set_text(str(item_stack.quantity)) 
	if item_stack.quantity > 1:
		slot_icon_ui.quantity.visible = true
	_refresh_style()

func _add_item_ui_icon() -> void:
	slot_icon_ui = slot_icon_ui_scene.instance()
	slot_icon_ui.name = "SlotItemIconUI"
	$CenterContainer.add_child(slot_icon_ui)
	slot_icon_ui.set_owner($CenterContainer)
