extends State

class_name IdleState

func _ready():
	animated_sprite.play("idle_" + direction_string[current_dir])
	state_name = "Idle"
	
func move():
	change_state.call_func("walking")

