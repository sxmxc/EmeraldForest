extends "res://Scenes/Menus/Menu.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var player = $HBoxContainer/CenterContainer/CharPreview/Player
@onready var confirmation = $Notifications/Alert/ConfirmationDialog

signal start_confirmed

# Called when the node enters the scene tree for the first time.
func _ready():
	confirmation.get_cancel().connect("pressed", self, "_on_dialog_cancel")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HairNext_pressed():
	player._change_hair()
	
func _on_PantsNext_pressed():
	player._change_pants()


func _on_ShirtNext_pressed():
	player._change_shirt()
	


func _on_ShoesNext_pressed():
	player._change_shoes()


func _on_AccNext_pressed():
	pass # Replace with function body.

func _on_BeardNext_pressed():
	pass # Replace with function body.



func _on_HairPrev_pressed():
	player._prev_hair()
	

func _on_BeardPrev_pressed():
	pass # Replace with function body.


func _on_ShirtPrev_pressed():
	player._prev_shirt()


func _on_PantsPrev_pressed():
	player._prev_pants()


func _on_ShoesPrev_pressed():
	player._prev_shoes()


func _on_AccPrev_pressed():
	pass # Replace with function body.


func _on_ConfirmationDialog_confirmed():
	emit_signal("start_confirmed")

func _on_dialog_cancel():
	confirmation.hide()


func _on_Begin_pressed():
	confirmation.popup_centered()


func _on_Back_pressed():
	visible = false
	emit_signal("menu_closed")


func _on_TextEdit_text_changed():
	pass # Replace with function body.
