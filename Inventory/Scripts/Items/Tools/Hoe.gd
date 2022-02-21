extends Tool

func _ready():
	#item_name = "%s Hoe" % tool_resource_dict[tool_resource]
	pass

func _use_item(tile_map, target_tile):
	Print.line(Print.BLUE,"Using %s" % item_name)
	var tile_id = get_tree().get_nodes_in_group("back")[0].get_cellv(target_tile)
	if Global.SOIL_ID.has(tile_id):
		get_tree().get_nodes_in_group("back")[0].set_cellv(target_tile, Global.TILLED_SOIL_ID)
		Global.world.farm_meta[target_tile].tillable = false
		Global.world.farm_meta[target_tile].id = Global.TILLED_SOIL_ID
		Global.world.farm_meta[target_tile].seeded = false

