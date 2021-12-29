extends Resource
class_name ItemType


enum Type { Tool,Food,CraftingResource,Clothing,Weapon,Equipment,Any }
export(Type) var item_type = Type.Tool

func _ready():
	pass
