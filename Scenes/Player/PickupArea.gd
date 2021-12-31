extends Area2D


func _ready():
	pass

var items_in_range = {}
func _on_PickupArea_body_entered(body):
	items_in_range[body] = body
	pass # Replace with function body.


func _on_PickupArea_body_exited(body):
	if items_in_range.has(body):
		items_in_range.erase(body)
	pass # Replace with function body.
