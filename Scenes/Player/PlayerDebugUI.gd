extends CanvasLayer

onready var state_label = $MarginContainer/Panel/VBoxContainer/CurrentState/HBoxContainer/State
onready var dir_label = $MarginContainer/Panel/VBoxContainer/CurrentDir/HBoxContainer/Dir

func _process(_delta):
	state_label.text = get_parent().get_node("StateMachine").state.state_name
	dir_label.text = get_parent().get_node("StateMachine").state.direction_string[get_parent().get_node("StateMachine").state.current_dir]
	
