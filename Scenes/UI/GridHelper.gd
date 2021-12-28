extends Node2D


onready var tile_map = get_parent().get_node("Back")
onready var paths_layer_tile_map = get_parent().get_node("Paths")
onready var player = get_parent().get_node("Buildings/Player")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var front_tile = _get_front_tile(tile_map)
	global_position = front_tile * 16

func _get_front_tile(tm):
	if player:
		var player_pos = player.get_node("PlayerTileAnchor").global_position
		var player_current_tile_position = tm.world_to_map(player_pos)
		var player_tile_front_position = player_current_tile_position + player.facing
		return player_tile_front_position
	
#need to move this into tool specific
func _unhandled_input(_event):
	if Input.is_action_pressed("player_use_tool"):
		var tile_id = tile_map.get_cellv(_get_front_tile(tile_map))
		if tile_id == Global.SOIL_ID:
			Print.line(Print.CYAN, "Tilling tileID: " + str(tile_id))
			tile_map.set_cellv(_get_front_tile(tile_map), tile_map.get_tileset().find_tile_by_name(Global.TILLED_SOIL_NAME))
			tile_map.tile_properties[_get_front_tile(tile_map)] = {"type": "dirt", "diggable": false,\
				 "isWatered": false, "action": null, "isBuildable": true,\
				 "waterSource": false, "water": false}
		if tile_id == Global.TILLED_SOIL_ID:
			Print.line(Print.CYAN, "Seeding tileID: " + str(tile_id))
			tile_map.set_cellv(_get_front_tile(tile_map), tile_map.get_tileset().find_tile_by_name(Global.SEEDED_SOIL_NAME))
	if Input.is_action_pressed("player_use_alternate"):
		var tile_id = tile_map.get_cellv(_get_front_tile(tile_map))
		if tile_id == Global.TILLED_SOIL_ID:
			Print.line(Print.CYAN, "Watering tileID: " + str(tile_id))
			tile_map.set_cellv(_get_front_tile(tile_map), tile_map.get_tileset().find_tile_by_name(Global.WET_SOIL_NAME))
			tile_map.tile_properties[_get_front_tile(tile_map)]["isWatered"] = true
