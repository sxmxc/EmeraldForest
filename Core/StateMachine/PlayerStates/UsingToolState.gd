extends State

class_name UsingToolState

func _ready():
	animated_sprite.connect("animation_finished", self, "on_anim_finish")
	animated_sprite.play("using_tool_" + direction_string[current_dir])
	state_name = "Using Tool"
	
func on_anim_finish(_anim):
	change_state.call_func("idle")

