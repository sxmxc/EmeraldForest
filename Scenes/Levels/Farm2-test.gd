extends Node2D

func _ready():
	Console.add_command('tile_details', self, '_get_tile_props')\
		.set_description('get tile details')\
		.register()


func _get_tile_props():
	for node in $farm_outside_1.get_children():
		if node is TileMap:
			for tile in node.tile_set.get_tiles_ids():
				if node.tile_set.has_meta("tile_meta"):
					var tile_meta = node.tile_set.get_meta("tile_meta")
					if tile_meta.has(tile):
						print("TileMap " + str(node))
						print("TileSet " + str(node.tile_set))
						print("Tile ID " + str(tile))
						print(tile_meta[tile])
						
					
