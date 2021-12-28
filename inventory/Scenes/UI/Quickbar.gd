extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var panels = $NinePatchRect/Margin/Grid.get_children()

var current_panel = 0
var prev_panel = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("quickbar_next"):
		prev_panel = current_panel
		current_panel = current_panel + 1 if current_panel + 1 < panels.size() else 0
	if event.is_action_pressed("quickbar_prev"):
		prev_panel = current_panel
		current_panel = current_panel - 1 if current_panel - 1 >= 0 else panels.size() -1
	panels[prev_panel].get_node("CenterContainer/Focus").visible = false
	panels[current_panel].get_node("CenterContainer/Focus").visible = true
