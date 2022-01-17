extends Control

onready var name_label = $NinePatchRect/MarginContainer/VBoxContainer/FarmName
onready var funds_label = $NinePatchRect/MarginContainer/VBoxContainer/Funds
onready var earnings_label = $NinePatchRect/MarginContainer/VBoxContainer/Earnings

func _ready():
	yield(SceneManager, "scene_loaded")
	name_label.text = SceneManager.get_entity("Player").current.farmname

