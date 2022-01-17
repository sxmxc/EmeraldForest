extends Node

onready var event_manager := $Dialog/EventManager
onready var dialog_node = $Dialog/DialogNode

const timeline = preload("res://dialogue/testTimeline.tres")

func _ready() -> void:
	yield(SceneManager, "scene_loaded")
	SceneManager.get_entity("Player")._load_data(Global.player_data)
	event_manager.timeline = timeline
	event_manager.event_node_path = dialog_node.get_path()
	event_manager.start_timeline(timeline)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dialog_move_down":
		$AnimationPlayer.play("Fade_in")
	if anim_name == "boss_man_enters":
		event_manager.go_to_next_event()	
	if anim_name == "player_quits":
		SceneManager.change_scene("res://Scenes/Cutscenes/Intro_Scene_2.tscn")


func _on_EventManager_event_finished(event):
	pass # Replace with function body.
