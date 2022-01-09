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
	Vector2.UP : "up",
	Vector2.LEFT: "left",
	Vector2.RIGHT: "right"
}

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(delta):
	persistent_state.move_and_slide(persistent_state.velocity,current_dir)

func setup(change_state, animated_sprite, persistent_state):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.persistent_state = persistent_state

func move():
	pass


