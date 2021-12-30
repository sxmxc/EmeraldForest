extends Node

export(Dictionary) var item_database = {}

var item = preload("res://inventory/Models/Item.gd")
#demo data
var axe = preload("res://inventory/Data/Items/Axe.tres")
var pickaxe = preload("res://inventory/Data/Items/Pickaxe.tres")


func _ready():
	#load some dummy data
	item_database[axe.item_id] = axe as Item
	item_database[pickaxe.item_id] = pickaxe as Item
	
	pass

func _get_item_by_id(id: int):
	if !item_database.has(id):
		Print.line(Print.RED, "Item with ID %s not found" % id)
		return null
	return item_database[id] as Item

func _get_item_by_name(name: String):
	for item in item_database:
		if item.item_name == name:
			return item as Item
	Print.line(Print.RED, "Item %s not found" % name)
	
