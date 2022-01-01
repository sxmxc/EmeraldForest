extends Panel

var default_tex = preload("res://Images/Assets/Aseprite/Container-Small.Container-Small.default.0.Atlas.res")
var empty_tex = preload("res://Images/Assets/Aseprite/Container-Small-Dark.Container-Small-Dark.default.0.Atlas.res")
var locked_tex = preload("res://Images/Assets/Aseprite/Container-Small-Dark.Container-Small-Dark.default.0.Atlas.res")
var selected_tex = preload("res://Images/Assets/Aseprite/HighlightSquare.HighlightSquare.default.0.Atlas.res")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var locked_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null

var item_class = preload("res://Inventory/Scenes/Item.tscn")
var item = null

var locked = false

var slot_idx: int

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	locked_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	locked_style.texture = locked_tex
	selected_style.texture = selected_tex
	
	# if randi() % 2 == 0:
	# 	item = item_class.instance()
	# 	add_child(item)
	_refresh_style()		
	pass
	
func _refresh_style():
	if item == null:
		set('custom_styles/panel', empty_style)
	elif locked:
		set('custom_styles/panel', locked_style)
	else:
		set('custom_styles/panel', default_style)
		
func _pick_from_slot():
	remove_child(item)
	var inventory_node = find_parent("Inventory")
	inventory_node.add_child(item)
	item = null
	_refresh_style()
	
func _put_into_slot(new_item):
	item = new_item
	item.position = Vector2.ZERO
	var inventory_node = find_parent("Inventory")
	inventory_node.remove_child(item)
	add_child(item)
	_refresh_style()

func _initialize_item(item_name, item_quantity):
	if item == null:
		item = item_class.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name,item_quantity)
	_refresh_style()
