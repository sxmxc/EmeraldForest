extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const body_spritesheets = {
	0: ["Male", preload("res://Images/Assets/SpriteSheets/Player/Base/male_base_0.png")]
	# need female
}
const hair_spritesheets = {
	0: ["Messy", preload("res://Images/Assets/SpriteSheets/Player/Hair/hair_0.png")]
}

const shirts_spritesheets = {
	0: ["Grey", preload("res://Images/Assets/SpriteSheets/Player/Shirts/shirt_0.png")],
	1: ["Green", preload("res://Images/Assets/SpriteSheets/Player/Shirts/shirt_1.png")]
}

const pants_spritesheets = {
	0: ["Jeans", preload("res://Images/Assets/SpriteSheets/Player/Pants/pants_0.png")],
	1: ["Shorts", preload("res://Images/Assets/SpriteSheets/Player/Pants/shorts_0.png")]
}

const shoes_spritesheets = {
	0: ["Boots", preload("res://Images/Assets/SpriteSheets/Player/Shoes/shoes_0.png")], 
	1: ["Sandals", preload("res://Images/Assets/SpriteSheets/Player/Shoes/sandals_0.png")]
}
const facialhair_spritesheets = {
	0: ["None", null]
}
const accessory_spritesheets = {
	0: ["None", null]
}




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
