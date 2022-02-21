extends Node2D

onready var animation_player = $AnimationPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_dialog()
	pass # Replace with function body.

func _start_dialog():
	var dialog = Dialogic.start("intro")
	dialog.connect("dialogic_signal", self, "_dialog_listener")
	add_child(dialog)
	
func _dialog_listener(string):
	match string:
		"start":
			pass
		"narration_finished":
			animation_player.play("fade in")
			yield(animation_player,"animation_finished")
			animation_player.play("boss_enters")
		"fade_out":
			animation_player.play("fade out")
		"timeline_finish":
			SceneManager.change_scene("res://Core/World.tscn")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
