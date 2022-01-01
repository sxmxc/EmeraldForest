extends StaticBody2D

var farm_map

export (int) var crop_type = 1
export (String) var object_name = ""

export (int) var current_phase = 0 #Seed phase
export (int) var day_of_current_phase = 0
export (int) var crop_age = 0
export (bool) var withered = false

func _initialize(data, farm):
	farm_map = farm
	crop_type = data.get("plant_id")
	object_name = data.get("object_name")
	current_phase = data.get("current_phase")
	crop_age = data.get("crop_age")
	
	return data

func _check_dirt_status():
	var dirt_pos = farm_map.world_to_map(global_position)
	if farm_map.tile_properties[dirt_pos]["isWatered"] == true:
		crop_age += 1
		day_of_current_phase += 1
	else:
		pass
	
func _check_plant_status(phase_days):
	var required_days = phase_days[current_phase]
	if day_of_current_phase == int(required_days):
		current_phase += 1
		day_of_current_phase = 0
	var anim = str("Phase " + str(current_phase))
	if current_phase == 0:
		$CollisionShape2D.disabled = true
	elif current_phase == len(phase_days) - 1:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
	$AnimationPlayer.play(anim)
	


func _ready():
	pass
