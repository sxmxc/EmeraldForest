extends Node

var inventories = []

signal inventory_updated

func _ready():
	pass

func _inventory_updated():
	emit_signal("inventory_updated")
	
func _register_inventory(inventory):
	inventories.append(inventory)
