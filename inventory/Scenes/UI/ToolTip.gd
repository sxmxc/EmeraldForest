extends NinePatchRect

const ItemStackClass = preload("res://inventory/Models/ItemStack.gd");

onready var itemNameLabel = get_node("VBoxContainer/ItemName");
onready var itemDescriptionLabel = get_node("VBoxContainer/ItemDescription");

func display(_item_stack : ItemStack, mousePos : Vector2):
	visible = true;
	itemNameLabel.set_text(_item_stack.item.item_name);
	itemDescriptionLabel.set_text("Description: %s" % _item_stack.item.item_description)
	rect_size = Vector2(128, 64);
	rect_global_position = Vector2(mousePos.x + 5, mousePos.y + 5);
