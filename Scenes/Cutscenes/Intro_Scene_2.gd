extends Node

onready var event_manager := $Dialog/EventManager
onready var dialog_node = $Dialog/DialogNode

const timeline = preload("res://dialogue/Intro_Scene_2.tres")

func _ready() -> void:
	yield(SceneManager, "scene_loaded")
	#SceneManager.get_entity("Player")._load_data(Global.player_data)
	event_manager.timeline = timeline
	event_manager.event_node_path = dialog_node.get_path()
	event_manager.start_timeline(timeline)


func _on_EventManager_event_finished(event):
	pass # Replace with function body.

func _on_EventManager_timeline_finished(timeline_resource):	
	SceneManager.change_scene("res://Scenes/Cutscenes/Intro_Scene_3.tscn")
