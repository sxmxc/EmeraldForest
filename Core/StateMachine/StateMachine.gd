extends Node2D

class_name StateMachine

var state
var state_factory
var body
var anim

func _ready():
	state_factory = StateFactory.new()
	
func _setup(b, a):
	body = b
	anim = a
# Input code was placed here for tutorial purposes.
func _process(_delta):
	pass		
	

func move():
	state.move()

func change_state(new_state_name):
	Print.line(Print.YELLOW, "Changing state to: " + new_state_name)
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), anim, body)
	state.name = "current_state"
	state.current_dir = body.facing
	add_child(state)
