extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Copper Pickaxe"
	elif rand_val == 2:
		item_name = "Copper Axe"
	else:
		item_name = "Copper Ore"
		
	$TextureRect.texture = load("res://Images/Assets/SpriteSheets/Chopped/" \
	+ JsonImporter.item_data[item_name]["Texture"])
	var stack_size = int(JsonImporter.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)
		
func _add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func _decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
	
func _use_item(tile_map,ft):
	Print.line(Print.BLUE,"Using %s" % item_name)
	if item_name == "Copper Pickaxe":
		var tile_id = tile_map.get_cellv(ft)
		if tile_id == Global.SOIL_ID:
			Print.line(Print.CYAN, "Tilling tileID: " + str(tile_id))
			tile_map.set_cellv(ft, tile_map.get_tileset().find_tile_by_name(Global.TILLED_SOIL_NAME))
			tile_map.tile_properties[ft] = {"type": "dirt", "diggable": false,\
				 "isWatered": false, "action": null, "isBuildable": true,\
				 "waterSource": false, "water": false}
	elif item_name == "Watering Can" :
		var tile_id = tile_map.get_cellv(ft)
		if tile_id == Global.TILLED_SOIL_ID:
			Print.line(Print.CYAN, "Watering tileID: " + str(tile_id))
			tile_map.set_cellv(ft, tile_map.get_tileset().find_tile_by_name(Global.WET_SOIL_NAME))
			tile_map.tile_properties[ft]["isWatered"] = true
	elif item_name == "Seed Pack" :
		var tile_id = tile_map.get_cellv(ft)
		if tile_id == Global.TILLED_SOIL_ID:
			Print.line(Print.CYAN, "Seeding tileID: " + str(tile_id))
			tile_map.set_cellv(ft, tile_map.get_tileset().find_tile_by_name(Global.SEEDED_SOIL_NAME))
func _set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://Images/Assets/SpriteSheets/Chopped/" \
	+ JsonImporter.item_data[item_name]["Texture"])

	var stack_size = int(JsonImporter.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)
	
