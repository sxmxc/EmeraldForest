extends KinematicBody2D

var speed = 100  # speed in pixels/sec

var velocity = Vector2.ZERO
var direction = "down"
var facing = Vector2.DOWN

onready var grid_helper = $GridHelper

export var can_control = false

var current_animation = "idle_" + direction

var pickup_radius

var player_name = Global.player_name
var farm_name = Global.farm_name

signal player_loaded

onready var current = {
	"playername" : player_name,
	"farmname": farm_name,
	"body" : 0,
	"hair" : 0,
	"shirt" : 0,
	"pants" : 0,
	"shoes" : 0,
	"facialhair" : 0,
	"accessory": 0,
	"date" : GameClock.current_date,
	"inventory": Global.player_data.inventory
}


onready var body_sprite = $CompositeSprites/Body
onready var hair_sprite = $CompositeSprites/Hair
onready var shirt_sprite = $CompositeSprites/Shirt
onready var pants_sprite = $CompositeSprites/Pants
onready var shoes_sprite = $CompositeSprites/Shoes
#onready var facialhair_sprite = $CompositeSprites/FacielHair
#onready var accessory_sprite = $CompositeSprites/Accessory

onready var spawn_parent = get_parent()
onready var spawn_point = Vector2(0,0)

const composite_sprites = preload("res://Scenes/Player/CompositeSprites.gd")


func _ready():
	body_sprite.texture = composite_sprites.body_spritesheets[current["body"]][1]
	hair_sprite.texture = composite_sprites.hair_spritesheets[current["hair"]][1]
	shirt_sprite.texture = composite_sprites.shirts_spritesheets[current["shirt"]][1]
	pants_sprite.texture = composite_sprites.pants_spritesheets[current["pants"]][1]
	shoes_sprite.texture = composite_sprites.shoes_spritesheets[current["shoes"]][1]
	#facialhair_sprite.texture = composite_sprites.facialhair_spritesheets[0]
	#accessory_sprite.texture = composite_sprites.accessory_spritesheets[0]
# warning-ignore:return_value_discarded
	GameClock.connect("night", self, "_on_night")
# warning-ignore:return_value_discarded
	GameClock.connect("morning", self, "_on_morning")
	$StateMachine._setup(self, $AnimationPlayer)
	$StateMachine.change_state("idle")
	Global._set_player(self)
	_setup_grid_helper()
	emit_signal("player_loaded")
	

func _load_data(data):
	current = data
	body_sprite.texture = composite_sprites.body_spritesheets[int(current["body"])][1]
	hair_sprite.texture = composite_sprites.hair_spritesheets[int(current["hair"])][1]
	shirt_sprite.texture = composite_sprites.shirts_spritesheets[int(current["shirt"])][1]
	pants_sprite.texture = composite_sprites.pants_spritesheets[int(current["pants"])][1]
	shoes_sprite.texture = composite_sprites.shoes_spritesheets[int(current["shoes"])][1]
	#facialhair_sprite.texture = composite_sprites.facialhair_spritesheets[0]
	#accessory_sprite.texture = composite_sprites.accessory_spritesheets[0]
	if data.has("inventory"):
		PlayerInventory._load(data["inventory"])

func _save():
	current["filename"] = get_filename()
	current["spawn_parent"] = spawn_parent
	current["spawn_point"] = spawn_point
	current["inventory"] = PlayerInventory._save()
	current["date"] = GameClock.current_date
	current["cash"] = 100
	return current
	
func _set_control(value = true):
	can_control = value
	grid_helper._set_active(value)

func _setup_grid_helper():
	grid_helper._set_player(self)
	Print.line(Print.GREEN,"Grid Helper setup on Player")

#need to decouple this more? maybe? too dependent on tilemaps
func _use_item(tile_map, active_tile):
	PlayerInventory._use_active_item(tile_map, active_tile)
	$StateMachine.change_state("usingTool")

func _update_state_machine():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		direction = "right"
		facing = Vector2.RIGHT
		
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		direction = "left"
		facing = Vector2.LEFT
		
	if Input.is_action_pressed('down'):
		velocity.y += 1
		direction = "down"
		facing = Vector2.DOWN
		
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		direction = "up"
		facing = Vector2.UP
		
	if velocity != Vector2.ZERO:
		$StateMachine._update()
			

# warning-ignore:unused_argument
func _physics_process(delta):
	if can_control:
		_update_state_machine()
		_pickup_items()

func _pickup_items():
	if $PickupArea.items_in_range.size() > 0:
		var item = $PickupArea.items_in_range.values()[0]
		item._pick_up_item(self)
		$PickupArea.items_in_range.erase(item)
		
func _change_shirt(): 
	current["shirt"] = (current["shirt"] + 1) % composite_sprites.shirts_spritesheets.size()
	shirt_sprite.texture = composite_sprites.shirts_spritesheets[current["shirt"]][1]
	
func _change_hair():
	hair_sprite.texture = composite_sprites.hair_spritesheets[current["hair"]][1]
	
func _change_pants():
	current["pants"] = (current["pants"] + 1) % composite_sprites.pants_spritesheets.size()
	pants_sprite.texture = composite_sprites.pants_spritesheets[current["pants"]][1]
	
func _change_shoes():
	current["shoes"] = (current["shoes"] + 1) % composite_sprites.shoes_spritesheets.size()
	shoes_sprite.texture = composite_sprites.shoes_spritesheets[current["shoes"]][1]

func _prev_shirt(): 
	current["shirt"] = (current["shirt"] - 1) if (current["shirt"] - 1) >= 0 else composite_sprites.shirts_spritesheets.size() - 1
	shirt_sprite.texture = composite_sprites.shirts_spritesheets[current["shirt"]][1]
	
func _prev_hair():
	hair_sprite.texture = composite_sprites.hair_spritesheets[current["hair"]][1]
	
func _prev_pants():
	current["pants"] = (current["pants"] - 1) if (current["pants"] - 1) >= 0 else composite_sprites.pants_spritesheets.size() - 1
	pants_sprite.texture = composite_sprites.pants_spritesheets[current["pants"]][1]
	
func _prev_shoes():
	current["shoes"] = (current["shoes"] - 1) if (current["shoes"] - 1) >= 0 else composite_sprites.shoes_spritesheets.size() - 1
	shoes_sprite.texture = composite_sprites.shoes_spritesheets[current["shoes"]][1]
	
func _on_morning():
	var light = $Light2D
	if light.visible == true:
		light.visible = false
		
func _on_night():
	var light = $Light2D
	if light.visible == false:
		light.visible = true

func _set_player_name(value):
	current.playername = value
	
func _set_farm_name(value):
	current.farmname = value
