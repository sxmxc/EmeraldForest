extends TileSet


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ids = []
var tileDict = {}

# Called when the node enters the scene tree for the first time.
func _init():
	ids = get_tiles_ids()
	if ids:
		for i in ids:
			tileDict[i] = tile_get_name(i)
		
		# Registering commands
	# 1. argument is command name
	# 2. arg. is target (target could be a funcref)
	# 3. arg. is target name (name is not required if it is the same as first arg or target is a funcref)
	Console.add_command('get_tile_dict', self, '_print_tile_dict')\
		.set_description('Prints all current tiles/tileIDs in tileset')\
		.register()
			

func _print_tile_dict():
	Console.write_line("-------------------------------")
	var header = "%-3s| %-25s%s"
	Console.write_line(header % ["ID","Name","|"])
	Console.write_line("-------------------------------")
	for i in tileDict:
		var line = "%-3s| %-25s%s"
		Console.write_line( line % [i,tileDict[i],"|"])
		Console.write_line("-------------------------------")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
