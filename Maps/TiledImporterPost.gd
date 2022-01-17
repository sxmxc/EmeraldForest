extends Node

# Traverse the node tree and replace Tiled objects
func post_import(scene):
	# Load scenes to instantiate and add to the level
	var spawn_point = load("res://Maps/SpawnPoint.tscn")
	var travel_point = load("res://Maps/TravelPoint.tscn")
	
	# The scene variable contains the nodes as you see them in the editor.
	# scene itself points to the top node. Its children are the tile and object layers.
	for node in scene.get_children():
		# To know the type of a node, check if it is an instance of a base class
		# The addon imports tile layers as TileMap nodes and object layers as Node2D
		if node is TileMap:
			# Process tile layers. E.g. read the ID of the individual tiles and
			# replace them with random variations, or instantiate scenes on top of them
			pass
		elif node is Node2D:
			for object in node.get_children():
				# Assume all objects have a custom property named "type" and get its value
				var type = object.get_meta("type")

				var node_to_clone = null
				if type == "spawn":
					node_to_clone = spawn_point
				elif type == "travel":
					node_to_clone = travel_point

				if node_to_clone:
					var new_instance = node_to_clone.instance()
					# Place the node on the object (top-left corner), and offset it by half a cell
					# so it is centered on the object
					new_instance.position = object.get_global_position() + Vector2(8, 8)
					if type == "spawn":
						new_instance.id = object.get_meta("id")
					if type == "travel":
						new_instance.destination = object.get_meta("destination")
						new_instance.destination_spawn = object.get_meta("spawn")
					
					# Add the node  as a child of the scene and sets
					# the scene as its owner. Otherwise, the scene doesn't get modified
					scene.add_child(new_instance)
					new_instance.set_owner(scene)
			# After you processed all the objects, remove the object layer
			node.free()
	# You must return the modified scene
	return scene

