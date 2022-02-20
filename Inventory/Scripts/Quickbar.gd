extends Inventory


@onready var hotbar = $HotbarSlots

func _ready():
	self.slots = hotbar.get_children()
	Global.player_menu_requested.connect(_initialize_quickbar)
	PlayerInventory.inventory_updated.connect(_update_quickbar)
	for i in range(slots.size()):
		PlayerInventory.active_item_updated.connect(slots[i]._refresh_style)
		slots[i].slot_idx = i
		slots[i].slot_type = slot_class.SlotType.QUICKBAR
		PlayerInventory._register_quickbar_slot(slots[i])
	_initialize_quickbar()

func _initialize_quickbar():
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i]._initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func _update_quickbar():
	Print.line(Print.BLUE,"Updating Quickbar")
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i]._initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
			_update_slot_visual(i,PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
		else:
			slots[i]._remove_item()
			
func _update_slot_visual(slot_index,item_name, item_quantity ):
	var slot = slots[slot_index]
	if slot.item != null:
		slot.item._set_item(item_name, item_quantity)
		
func _input(event):
	if event.is_action_pressed('quickbar_next'):
			PlayerInventory._active_item_scroll_up()
			
	if event.is_action_pressed("quickbar_prev"):
			PlayerInventory._active_item_scroll_down()
			
