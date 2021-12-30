extends Resource
class_name Item

export(int) var item_id
export(String) var item_name
export(ItemType.Type) var item_type
export(String) var item_description
export(bool) var stackable
export(int) var max_stack
export(Texture) var item_icon
export(PackedScene) var item_scene


func _ready():
	pass
