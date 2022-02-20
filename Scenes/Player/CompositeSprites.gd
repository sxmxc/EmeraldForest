extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#work around for gd4 bug

const BODIES = {"name": "Male", "texture": preload("res://Images/Assets/SpriteSheets/Player/Base/male_base_0.png")}
const BODY_SPRITESHEETS = {
	0: BODIES
}
const HAIR = {"name": "Messey", "texture": preload("res://Images/Assets/SpriteSheets/Player/Hair/hair_0.png")}
const HAIR_SPRITESHEETS = {
	0: HAIR
}
const SHIRTS = {"Grey": preload("res://Images/Assets/SpriteSheets/Player/Shirts/shirt_0.png"),"Green": preload("res://Images/Assets/SpriteSheets/Player/Shirts/shirt_1.png")}
const SHIRTS_SPRITESHEETS = {
	0: SHIRTS.Grey,
	1: SHIRTS.Green
}
const PANTS = {"Jeans": preload("res://Images/Assets/SpriteSheets/Player/Pants/pants_0.png"),"Shorts": preload("res://Images/Assets/SpriteSheets/Player/Pants/shorts_0.png")}
const PANTS_SPRITESHEETS = {
	0: PANTS.Jeans,
	1: PANTS.Shorts
}
const SHOES = {"Boots": preload("res://Images/Assets/SpriteSheets/Player/Shoes/shoes_0.png"),"Sandals": preload("res://Images/Assets/SpriteSheets/Player/Shoes/sandals_0.png")}
const SHOES_SPRITESHEETS = {
	0: SHOES.Boots, 
	1: SHOES.Sandals
}
const FACIALHAIR = {"None": null}
const FACIALHAIR_SPRITESHEETS = {
	0: FACIALHAIR.None
}
const ACCESSORY = {"None": null}
const ACCESSORY_SPRITESHEETS = {
	0: ACCESSORY.None
}




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
