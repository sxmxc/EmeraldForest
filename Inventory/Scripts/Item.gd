extends Node2D

var item_name
var item_quantity

func _ready():
	pass
		
func _add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func _decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
	
func _use_item(tile_map,target_tile):
	Print.line(Print.BLUE,"Using %s" % item_name)
	if item_name == "Copper Pickaxe":
		var tile_id = tile_map.get_cellv(target_tile)
		if tile_id == Global.SOIL_ID:
			#Print.line(Print.CYAN, "Tilling tileID: " + str(tile_id))
			tile_map.set_cellv(target_tile, tile_map.get_tileset().find_tile_by_name(Global.TILLED_SOIL_NAME))
			tile_map.tile_properties[target_tile] = {"type": "dirt", "diggable": false,\
				 "isWatered": false, "action": null, "isBuildable": true,\
				 "waterSource": false, "water": false, "seeded": false}
	elif item_name == "Watering Can" :
		var tile_id = tile_map.get_cellv(target_tile)
		if tile_id == Global.TILLED_SOIL_ID:
			#Print.line(Print.CYAN, "Watering tileID: " + str(tile_id))
			tile_map.set_cellv(target_tile, tile_map.get_tileset().find_tile_by_name(Global.WET_SOIL_NAME))
			tile_map.tile_properties[target_tile]["isWatered"] = true
	elif item_name == "Seed Pack" :
		var tile_id = tile_map.get_cellv(target_tile)
		if (tile_id == Global.TILLED_SOIL_ID || tile_id == Global.WET_SOIL_ID) && \
		tile_map.tile_properties[target_tile]["seeded"] == false:
			#Print.line(Print.CYAN, "Seeding tileID: " + str(tile_id))
			var crop_path = "res://Farming/Plants/TestPlant.tscn"
			var crop = load(crop_path).instance()
			crop.add_to_group("crops")
			crop._initialize(PlantImporter.item_data["1"],tile_map)
			crop.global_position = tile_map.map_to_world(target_tile) + Global.CELL_SIZE / 2
			tile_map.add_child(crop)
			tile_map.tile_properties[target_tile]["seeded"] = true
			PlayerInventory._remove_item_quantity(item_name,1)
			
func _set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://Images/Assets/SpriteSheets/Chopped/" \
	+ ItemImporter.item_data[item_name]["Texture"])

	var stack_size = int(ItemImporter.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)
	
