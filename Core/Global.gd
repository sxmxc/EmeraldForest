extends Node2D


# Declare member variables here. Examples:
const GRASS_ID = [1, 2, 3, 4, 9, 10, 12, 17, 18, 19, 20, 25, 26, 27, 28, 6, 7, 8, 14, 15, 16, 22, 23, 24]
const SOIL_ID = [11, 5, 13, 21, 29, 30]
const TILLED_SOIL_ID = 31
const WET_SOIL_ID = 32
const CELL_SIZE = Vector2(16,16)

@export var debug := true

var farm_map
var world

var player_name = "Steeb"
var farm_name = "Tegridy Farms"
var player
var default_data = {
	"playername" : player_name,
	"farmname": farm_name,
	"body" : 0,
	"hair" : 0,
	"shirt" : 0,
	"pants" : 0,
	"shoes" : 0,
	"facialhair" : 0,
	"accessory": 0,
	"inventory" : { 0: ["Axe", 1],
	1: ["Hoe", 1],
	2: ["Pickaxe", 1],
	3: ["WateringCan", 1],
	4: ["SeedPack", 9] #need to remove this from default
#--> slot_index: [item_name, quantity]
}
}

@onready var player_data = default_data

signal player_menu_requested
signal day_end
signal new_day_start

# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	GameClock.safety_meeting.connect(_safety_meeting)
	GameClock.four_twenty_bb.connect(_four_twenty)
	GameClock.day_end.connect(_end_day)
#	Console.toggled.connect(_on_console_toggled)
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().set_auto_accept_quit(false)
#	Console.add_command('set_debug', self, '_set_debug')\
#		.set_description('Sets debug option')\
#		.add_argument('value', TYPE_BOOL)\
#		.register()
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
	if Input.is_action_just_pressed("ui_player_menu"):
		emit_signal("player_menu_requested")

func _register_world(wrld):
	world = wrld
	farm_map = wrld.farm_map
	world.connect("world_loaded", self, "_on_world_loaded")
	world.connect("map_changed", self, "_on_map_changed")
	world.connect("map_instanced", self, "_on_map_instanced")
	
func _store_player(data):
#	for key in data.keys():
#		player_data[key] = data[key]
	player_data = data
	
func _set_player(p):
	player = p

func _retrieve_player():
	return player_data
func _clear_player():
	player_data = default_data
#	SceneManager.get_entity("Player").current = player_data
	
func _save_game():
	var json_obj = JSON.new()
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
		save_game.store_line(json_obj.stringify(node_data))
	save_game.close()

func _load_game():
	var json_obj = JSON.new()
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
#	# Load the file line by line and process that dictionary to restore
#	# the object it represents.
	_clear_player()
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
#		# Get the saved dictionary from the next line in the save file
		var node_data = json_obj.parse_json(save_game.get_line())
		var p_data = {}
#		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			p_data[i] = node_data[i]
		_store_player(p_data)
	save_game.close()
	pass

func _notification(notif):
	if notif == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		_confirm("Exit to desktop?", "_quit", "Confirmation")
		
		
func _quit():
	get_tree().quit() # default behavior
	
func _on_quit_request():
	get_tree().notification(Node.NOTIFICATION_WM_CLOSE_REQUEST)
	
func _on_world_loaded():
	Print.line(Print.GREEN, "World Loaded")
#	player = SceneManager.get_entity("Player")
	var spawn_points = get_tree().get_nodes_in_group("spawn_points")
	var target_location
	for point in spawn_points:
		if point.id == 0:
			target_location = point.global_position
	
	if player != null:
		Print.line(Print.GREEN, "Player present")
#		SceneManager.get_entity("Player")._load_data(Global.player_data)
		#SceneManager.get_entity("Player").grid_helper._set_tilemap(world.farm_map)
#		SceneManager.get_entity("Player")._set_control(true)
#		SceneManager.get_entity("Player").get_node("Light2D").visible = false
#		SceneManager.get_entity("Player").get_node("Camera2D").make_current()
#		SceneManager.get_entity("Player").global_position = target_location
		GameClock._resume_game_clock()
		
	
	
	pass

func _on_map_changed():
	pass


func _on_map_instanced():
	Print.line(Print.GREEN, "Map instanced")
	
func _return_to_main_menu():
	InteractiveSceneChanger.load_scene('res://Scenes/Menus/StartScreen.tscn')
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
	dialog.modal_closed.connect(dialog.queue_free())
	dialog.confirmed.connect(cb)
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
	

