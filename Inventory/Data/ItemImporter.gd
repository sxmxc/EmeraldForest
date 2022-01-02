extends Node

var item_data: Dictionary
var db_filepath = "res://Inventory/Data/ItemDB.json"

func _ready():
	item_data = LoadData(db_filepath)


func LoadData(file_path):
	var json_data
	var file_data = File.new()
	var error = file_data.open(file_path, File.READ)
	
	if error == OK:
		Print.line(Print.BLUE, "ItemDB file found")
		json_data = JSON.parse(file_data.get_as_text())
		if json_data.error == OK:
			Print.line(Print.BLUE, "ItemDB file Parsed succesfully")
			file_data.close()
			return json_data.result
		else:
			printerr("Error %s at line %s: %s" % [json_data.error, json_data.error_line, json_data.error_string])
		file_data.close()
		return json_data.result
	else:
		Print.line(Print.BLUE, "Couldn't find ItemDB. Error %s " % str(error))
		
