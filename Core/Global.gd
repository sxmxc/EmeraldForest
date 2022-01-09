extends Node2D


# Declare member variables here. Examples:
const GRASS_ID = 1
const GRASS_NAME = "GrassSingle"
const SOIL_ID = 7
const SOIL_NAME = "FertileAuto"
const TILLED_SOIL_ID = 2
const TILLED_SOIL_NAME = "TilledSoilSingle" 
const WET_SOIL_ID = 9 
const WET_SOIL_NAME = "WateredSoilAuto"
const SEEDED_SOIL_ID = 10
const SEEDED_SOIL_NAME = "SeedSingle"
const CELL_SIZE = Vector2(16,16)

export(bool) var debug = true

var farm_map

var player_name = "Steeb"
var player
onready var player_data = {
	"playername" : player_name,
	"inventory" : { 0: ["Copper Pickaxe", 1],\
	1: ["Copper Axe", 1],\
	2: ["Copper Ore", 97],\
	3: ["Watering Can", 1],\
	4: ["Seed Pack", 9]
#--> slot_index: [item_name, quantity]
},
	"body" : 0,
	"hair" : 0,
	"shirt" : 0,
	"pants" : 0,
	"shoes" : 0,
	"facialhair" : 0,
	"accessory": 0	
}

var tile_dict = {}
var tile_properties = {}


signal player_menu_requested
signal day_end
signal new_day_start

# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var e = GameClock.connect("safety_meeting", self, "_safety_meeting")
	e = GameClock.connect("four_twenty_bb", self, "_four_twenty")
	e = Console.connect("toggled", self, "_on_console_toggled")
	e = GameClock.connect("day_end", self, "_end_day")
	if e:
		print_debug(e)
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().set_auto_accept_quit(false)
	Console.add_command('set_debug', self, '_set_debug')\
		.set_description('Sets debug option')\
		.add_argument('value', TYPE_BOOL)\
		.register()
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	_get_input()
#	passss
	
func _end_day():
	emit_signal("day_end")
	_start_day()
func _start_day():
	emit_signal("new_day_start")
func _get_input():
	if Input.is_action_just_pressed("ui_player_menu") && !Console.is_console_shown:
		emit_signal("player_menu_requested")
	
func _store_player(data):
	player_data = data

func _retrieve_player():
	return player_data
func _clear_player():
	player_data = null
	
func _save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes= get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("_save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("_save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	save_game.close()

func _load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
#	# Load the file line by line and process that dictionary to restore
#	# the object it represents.
	_clear_player()
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
#		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())
		var player_data = {}
#		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			player_data[i] = node_data[i]
		_store_player(player_data)
	save_game.close()
	pass

func _notification(notif):
	if notif == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_confirm("Exit to desktop?", "_quit", "Confirmation")
		
		
func _quit():
	get_tree().quit() # default behavior
	
func _on_quit_request():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _return_to_main_menu():
	SceneManager.change_scene('res://Scenes/Menus/StartScreen.tscn')
	if get_tree().paused:
		get_tree().paused = false

func _on_console_toggled(visible):
	if(visible):
		get_tree().paused = true
	else:
		get_tree().paused = false

	
func _safety_meeting():
	Print.line(Print.CYAN, "Wouldcha look at the time? SAFETY MEETING!" )
	Print.line(Print.GREEN,"        W\n       WWW\n       WWW\n      WWWWW\nW     WWWWW     W\nWWW   WWWWW   WWW\n WWW  WWWWW  WWW\n  WWW  WWW  WWW\n   WWW WWW WWW\n     WWWWWWW\n  WWWW  |  WWWW\n       |\n     |")
	
func _four_twenty():
	print("Happy holdays!")
	print("        W\n       WWW\n       WWW\n      WWWWW\nW     WWWWW     W\nWWW   WWWWW   WWW\n WWW  WWWWW  WWW\n  WWW  WWW  WWW\n   WWW WWW WWW\n     WWWWWWW\n  WWWW  |  WWWW\n       |\n     |")

func _confirm(text: String, cb: String, title: String='Confirm') -> void:
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_closed', dialog, 'queue_free')
	dialog.connect("confirmed", self, cb)
	var scene_tree = Engine.get_main_loop()
	if scene_tree.current_scene.get_node("Notifications/Alert"):
		scene_tree.current_scene.get_node("Notifications/Alert").add_child(dialog)
	else:
		scene_tree.current_scene.add_child(dialog)
	dialog.set_exclusive(true)
	dialog.popup_centered()

func _set_debug(value: bool):
	debug = value
	
func _get_debug():
	return debug
