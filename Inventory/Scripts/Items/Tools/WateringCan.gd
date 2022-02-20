extends Tool



func _use_item(tile_map,target_tile):
	var tile_id = tile_map.get_cellv(target_tile)
	if tile_id == Global.TILLED_SOIL_ID:
		#Print.line(Print.CYAN, "Watering tileID: " + str(tile_id))
		tile_map.set_cellv(target_tile, Global.WET_SOIL_ID)
		Global.world.farm_meta[target_tile].watered = true
		Global.world.farm_meta[target_tile].id = Global.WET_SOIL_ID

