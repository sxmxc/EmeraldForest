extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal menu_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_menu_closed():
	emit_signal("menu_closed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
