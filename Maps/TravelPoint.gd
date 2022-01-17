extends Node2D

export var destination = "Farm Inside"
export var destination_spawn = 0

#export var destination_scene = "res://Scenes/Levels/Farm_House_Inside.tscn"


#func _change_scene():
#	SceneManager.change_scene(destination_scene)

func _change_map():
	get_tree().root.get_node("World")._change_map(destination, destination_spawn)


func _on_Area2D_body_entered(body):
	#Global._store_player(SceneManager.get_entity("Player").current)
	print(body.name)
	_change_map()

