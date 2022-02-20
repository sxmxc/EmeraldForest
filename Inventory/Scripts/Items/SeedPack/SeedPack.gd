extends Item

func _use_item(tile_map,target_tile):
	var tile_id = tile_map.get_cellv(target_tile)
	if (tile_id == Global.TILLED_SOIL_ID || tile_id == Global.WET_SOIL_ID) && \
	Global.world.farm_meta[target_tile].seeded == false:
		var crop_path = "res://Farming/Plants/TestPlant.tscn"
		var crop = load(crop_path).instance()
		crop.add_to_group("crops")
		crop._initialize(PlantImporter.item_data["1"],tile_map)
		crop.global_position = tile_map.map_to_world(target_tile) + Global.CELL_SIZE / 2
		tile_map.add_child(crop)
		Global.world.farm_meta[target_tile].seeded = true
		PlayerInventory._remove_item_quantity(item_name,1)
