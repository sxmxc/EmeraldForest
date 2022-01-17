extends Node2D

const FARM_OUTSIDE := "Farm Outside"
const FARM_INSIDE := "Farm Inside"

# warning-ignore:unused_signal
signal world_loaded
# warning-ignore:unused_signal
signal map_changed
# warning-ignore:unused_signal
signal player_loaded_into_world

signal map_instanced

export var maps = {
	FARM_OUTSIDE : "res://Scenes/Levels/farm_outside_1.tscn",
	FARM_INSIDE : "res://Scenes/Levels/Farm_House_Inside.tscn"
}

var map_instances = {
	FARM_OUTSIDE : null,
	FARM_INSIDE : null
}

const STARTING_MAP = FARM_OUTSIDE
var current_map = STARTING_MAP
var current_map_instance
var farm_map
var previous_map

func _ready():
	yield(SceneManager, "scene_loaded")
	connect("map_changed", self, "_on_map_changed")
	self._instance_map(STARTING_MAP)
	yield (self,"map_instanced")
	farm_map = map_instances[current_map].get_child(0)
	_register_with_global()
	self.call_deferred("emit_signal","world_loaded")
	Console.add_command('tile_details', self, '_get_tile_props')\
		.set_description('get tile details')\
		.register()
	Console.add_command('tile_cell_count', self, '_print_tile_cell_count')\
		.set_description('Prints all current tiles/tileIDs')\
		.register()
	Console.add_command('tillable_tiles', self, '_print_tillable_tile_count')\
		.set_description('Prints total tillable tiles on map')\
		.register()

func _register_with_global():
	Global._register_world(self)

func _instance_map(map_key:String) -> void:
	var player = SceneManager.get_entity("Player")
	player.get_parent().call_deferred("remove_child",player)
	map_instances[map_key] = load(maps[map_key]).instance()
	current_map = map_key
	current_map_instance = map_instances[current_map]
	self.call_deferred("add_child", map_instances[current_map])
	current_map_instance.call_deferred("add_child", player)
	self.call_deferred("emit_signal","map_instanced")
	


func _change_map(map_key, destination_spawn):
	if map_instances.has(map_key):
		var current_map_node = map_instances[current_map]
		var player = SceneManager.get_entity("Player")
		player.get_parent().call_deferred("remove_child",player)
		
		self.call_deferred("remove_child", current_map_node)
		
		if map_instances[map_key] == null:
			_instance_map(map_key)
		else:
			self.call_deferred("add_child", map_instances[map_key])
		current_map = map_key
		current_map_node = map_instances[current_map]
		current_map_instance = current_map_node
		current_map_node.call_deferred("add_child", player)
		self.call_deferred("emit_signal", "map_changed")
		self.call_deferred("_position_player", destination_spawn)
		
	else:
		Print.line(Print.RED, "Map [%s] not found" % map_key)

func _position_player(destination):
	var player = SceneManager.get_entity("Player")
	var destination_point 
	var spawn_points = get_tree().get_nodes_in_group("spawn_points")
	for point in spawn_points:
		if point.id == destination:
			destination_point = point.global_position
	player.set_global_position(destination_point)

func _on_world_loaded():
	pass
	
func _on_map_changed():
	pass
		
func _get_tile_props():
	var map_instance_path = current_map_instance.get_path()
	var children = get_node(map_instance_path).get_children()
	for node in children:
		if node is TileMap:
			Console.write_line("%s meta data: %s" % [node.name ,node.tile_set.get_meta_list()])

func _print_tile_cell_count():
	var map_instance_path = current_map_instance.get_path()
	var children = get_node(map_instance_path).get_children()
	Console.write_line("Tilemap path: %s" % map_instance_path)
	for node in children:
		if node is TileMap:
			Console.write_line("%s total cells: %s" % [node.name , str(node.get_used_cells().size())])

func _print_tillable_tile_count():
	var map_instance_path = current_map_instance.get_path()
	var children = get_node(map_instance_path).get_children()
	
	Console.write_line("Tilemap path: %s" % map_instance_path)
	for node in children:
		if node is TileMap:
			Console.write_line("%s total cells: %s" % [node.name , str(node.get_used_cells().size())])
			if node.tile_set.has_meta("tile_meta"):
				var tile_meta = node.tile_set.get_meta("tile_meta")
				var total = 0
				for tile in node.get_used_cells():
					var tile_id = node.get_cellv(tile)
					if tile_meta.has(tile_id):
						if tile_meta[tile_id].has("tillable"):
							if tile_meta[tile_id].tillable == true:
								total +=1
				Console.write_line("Total tillabled tiles %s" % str(total))
					
	

#func _get_tile_properties(index):
#	return tile_properties[index]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
