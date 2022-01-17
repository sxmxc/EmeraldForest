extends Node2D

onready var back_layer = $Back

func _ready():
	Print.line(Print.GREEN,"Farm Outside Ready")
	back_layer = $Back

