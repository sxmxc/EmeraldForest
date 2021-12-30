extends Panel
class_name InventorySlotUI

var slot_icon_ui
var slot_idx

signal picked_from_slot
signal placed_in_slot


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const slot_icon_ui_scene = preload("res://inventory/Scenes/UI/InventorySlotItemUI.tscn")

export(bool) var locked
	

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _setup_slot():
	if not $CenterContainer.has_node("SlotItemIconUI"):
		_add_item_ui_icon()
	else:
		slot_icon_ui = $CenterContainer/SlotItemIconUI
		


#func _process(delta: float) -> void:
#	_refresh_style()

func _pick_from_slot():
	$CenterContainer.remove_child(slot_icon_ui)
	slot_icon_ui = null

func _put_into_slot(slot_icon):
	if !locked:
		slot_icon_ui = slot_icon
		slot_icon_ui.position = Vector2(0,0)
		$CenterContainer.add_child(slot_icon_ui)
		slot_icon_ui.set_owner($CenterContainer)
	
	
func _add_item_to_slot(item_stack):
	_setup_slot()
	slot_icon_ui.current_item_stack = item_stack
	slot_icon_ui.item_icon.texture = item_stack.item.item_icon
	slot_icon_ui.quantity.set_text(str(item_stack.quantity)) 
	if item_stack.quantity > 1:
		slot_icon_ui.quantity.visible = true

func _add_item_ui_icon() -> void:
	slot_icon_ui = slot_icon_ui_scene.instance()
	slot_icon_ui.name = "SlotItemIconUI"
	$CenterContainer.add_child(slot_icon_ui)
	slot_icon_ui.set_owner($CenterContainer)
