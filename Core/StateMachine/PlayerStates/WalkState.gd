extends State

class_name WalkState

func _ready():
	state_name = "Walking"
	animated_sprite.play("walk_" + direction_string[persistent_state.facing])
	# Make sure diagonal movement isn't faster
	persistent_state.velocity = persistent_state.velocity.normalized() * persistent_state.speed

func _physics_process(delta):
	if (persistent_state.velocity == Vector2.ZERO):
		change_state.call_func("idle")
	else:
		persistent_state.velocity = persistent_state.velocity.normalized() * persistent_state.speed
		if current_dir != persistent_state.facing:
			current_dir = persistent_state.facing
			animated_sprite.play("walk_" + direction_string[persistent_state.facing])
func move():
	pass
	

