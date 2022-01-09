extends State

class_name UsingToolState

func _ready():
	animated_sprite.play("idle_" + direction_string[current_dir])
	state_name = "usingTool"
	
func move():
	change_state.call_func("walking")

