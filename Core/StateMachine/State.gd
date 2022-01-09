extends Node2D
class_name State

var change_state
var state_name
var animated_sprite
var persistent_state
var velocity = Vector2.ZERO
var current_dir = Vector2.DOWN
var direction_string = {
	Vector2.DOWN : "down",
	Vector2(-1,-1) : "up",
	Vector2(-1,1) : "down",
	Vector2.UP : "up",
	Vector2(1,-1) : "up",
	Vector2(1,1) : "down",
	Vector2.LEFT: "left",
	Vector2.RIGHT: "right"
}

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(delta):
	persistent_state.move_and_slide(persistent_state.velocity,current_dir)

func setup(changeState, anim, persistState):
	self.change_state = changeState
	self.animated_sprite = anim
	self.persistent_state = persistState

func move():
	pass

func _get_input():
	pass

