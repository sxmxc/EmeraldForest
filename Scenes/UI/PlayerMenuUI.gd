extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var e = Global.connect("player_menu_requested", self, "toggle_menu")
	if (e):
		print_debug(e)

func toggle_menu():
	if (!visible):
		GameClock._pause_game_clock()
		visible = true
		get_tree().paused = true
	else:
		GameClock._resume_game_clock()
		visible = false
		get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ExitButton_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_QuitButton_pressed():
	Global._confirm("Quit and return to Main Menu?", "_return_to_main_menu", "Confirmation")
