extends Node2D


var tile_map
var paths_layer_tile_map
var player
var isActive
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal grid_helper_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	isActive = false
	pass # Replace with function body.

func _set_tilemap(tm):
	tile_map = tm

func _set_active(arg = true):
	isActive = arg

func _set_player(p):
	player = p

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isActive:
		visible = true
		tile_map = Global.world.farm_map as TileMap
		if tile_map:
			global_position = _get_active_tile(tile_map) * 16
	else:
		visible = false

func _get_active_tile(tm):
	var mouse_pos = get_global_mouse_position()
	var mouse_tile_pos = tm.world_to_map(mouse_pos)
	var adjacents = _get_adjacent_tiles(tm)
	var front_tile = _get_front_tile(tm)
	if adjacents.has(mouse_tile_pos):
		return mouse_tile_pos
	else:
		return front_tile

func _get_front_tile(tm):
	if player:
		var player_pos = player.get_node("PlayerTileAnchor").global_position
		var player_current_tile_position = tm.world_to_map(player_pos)
		var player_tile_front_position = player_current_tile_position + player.facing
		return player_tile_front_position
			
		
func _get_adjacent_tiles(tm):
	var adjacent = []
	if player:
		var player_pos = player.get_node("PlayerTileAnchor").global_position
		var player_current_tile_position = tm.world_to_map(player_pos)
		adjacent.append(player_current_tile_position + Vector2.UP)
		adjacent.append(player_current_tile_position + Vector2.DOWN)
		adjacent.append(player_current_tile_position + Vector2.LEFT)
		adjacent.append(player_current_tile_position + Vector2.RIGHT)
		adjacent.append(player_current_tile_position + Vector2(1,1))
		adjacent.append(player_current_tile_position + Vector2(-1,1))
		adjacent.append(player_current_tile_position + Vector2(-1,-1))
		adjacent.append(player_current_tile_position + Vector2(1,-1))
	return adjacent
	
#need to move this into tool specific
#func _unhandled_input(_event):
#	if isActive && player.can_control:
#		if Input.is_action_pressed("player_use_tool"):
#			player.facing = _get_active_tile(tile_map) - tile_map.world_to_map(player.get_node("PlayerTileAnchor").global_position)
#			player._use_item(tile_map, _get_active_tile(tile_map))
		
		
		
