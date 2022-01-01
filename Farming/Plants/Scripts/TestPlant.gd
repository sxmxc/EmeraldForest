extends "res://Farming/Plants/Scripts/Plant.gd"

export (Array) var phase_days = []


func _ready():
	Global.connect("day_end", self, "_on_end_day")
	_check_dirt_status()
	_check_plant_status(phase_days)
	pass

func _initialize(crop_data, farm):
	._initialize(crop_data, farm)
	phase_days = crop_data.get("phase_days")
	
	$AnimationPlayer.play(str("Phase " + str(current_phase)))
	
func _on_end_day():
	_check_dirt_status()
	_check_plant_status(phase_days)	

