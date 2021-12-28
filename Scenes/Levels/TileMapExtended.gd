extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tile_properties = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var used_cells = get_used_cells()
	if (used_cells):
		for i in used_cells:
			var tile_id = get_cellv(i)
			if tile_id == Global.GRASS_ID:
				tile_properties[i] = {"type": "grass", "diggable": false,\
				 "isWatered": false, "action": null, "isBuildable": true,\
				 "waterSource": false, "water": false}
			if tile_id == Global.SOIL_ID:
				tile_properties[i] = {"type": "dirt", "diggable": true,\
				 "isWatered": false, "action": null, "isBuildable": true,\
				 "waterSource": false, "water": false}
			if tile_id == Global.TILLED_SOIL_ID:
				tile_properties[i] = {"type": "dirt", "diggable": false,\
				 "isWatered": false, "action": null, "isBuildable": true,\
				 "waterSource": false, "water": false}
	Global.tile_properties = tile_properties
	# Registering commands
	# 1. argument is command name
	# 2. arg. is target (target could be a funcref)
	# 3. arg. is target name (name is not required if it is the same as first arg or target is a funcref)
	Console.add_command('tile_cell_count', self, '_print_tile_cell_count')\
		.set_description('Prints all current tiles/tileIDs')\
		.register()
	
func _print_tile_cell_count():
	Console.write_line("Total cells: " + str(Global.tile_properties.size()))
#	if Global.tile_properties.size() != tile_properties.size():
#		Console.write_line("Well this is akward." +\
#		"\nLooks like our LOCAL and GLOBAL tile properties dictionary is out of sync")
#		Console.write_line("Syncing it back up")
#		Global.tile_properties = tile_properties

func _get_tile_properties(index):
	return tile_properties[index]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
