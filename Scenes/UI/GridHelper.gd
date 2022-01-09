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
	global_position = _get_active_tile(tile_map) * 16

func _get_active_tile(tm):
	var mouse_pos = get_global_mouse_position()
	var mouse_tile_pos = tile_map.world_to_map(mouse_pos)
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
func _unhandled_input(_event):	
	if Input.is_action_pressed("player_use_tool"):
		player.facing = _get_active_tile(tile_map) - tile_map.world_to_map(player.get_node("PlayerTileAnchor").global_position)
		player._use_item(tile_map, _get_active_tile(tile_map))
		
		
		
