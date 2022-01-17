extends Node2D

export var destination_scene = "res://Scenes/Levels/Farm_House_Inside.tscn"
export var destination_map = "Farm Inside"


func _change_scene():
	SceneManager.change_scene(destination_scene)

func _change_map():
	SceneManager.get_entity("GameWorld")._change_map(destination_map, get_tree().get_nodes_in_group("warp")[0])


func _on_Area2D_body_entered(body):
	#Global._store_player(SceneManager.get_entity("Player").current)
	_change_map()
