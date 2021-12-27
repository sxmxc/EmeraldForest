extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mainMenu
var charCreator
var settingsMenu


# Called when the node enters the scene tree for the first time.
func _ready():
	mainMenu = get_node("MenuRoot/MainMenu")
	charCreator = get_node("MenuRoot/CharacterCreator")
	settingsMenu = get_node("MenuRoot/SettingsMenu")
	if (!GameClock.time_paused):
		GameClock._pause_game_clock()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGameButton_pressed():
	mainMenu.visible = false
	charCreator.visible = true


func _on_ContinueButton_pressed():
	pass


func _on_SettingsButton_pressed():
	mainMenu.visible = false
	settingsMenu.visible = true


func _on_QuitButton_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_SettingsMenu_menu_closed():
	mainMenu.visible=true


func _on_CharacterCreator_menu_closed():
	mainMenu.visible=true
