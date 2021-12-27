extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(SceneManager, "scene_loaded")
	SceneManager.get_entity("Player")._load_data(Global.player_data)
	SceneManager.get_entity("Player").can_control = true
	SceneManager.get_entity("Player").get_node("Camera2D").make_current()
	GameClock._resume_game_clock()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
