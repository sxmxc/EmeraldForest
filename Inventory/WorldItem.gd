extends KinematicBody2D

var item_name
const ACCELERATION = 460
const MAX_SPEED = 225

var velocity = Vector2.ZERO

var player = null
var being_picked_up = false


func _ready():
	item_name = "Copper Ore"
	pass

func _physics_process(delta):
	if (being_picked_up == false):
		velocity = Vector2.ZERO
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory._add_item(item_name, 1)
			queue_free()

	velocity = move_and_slide(velocity, Vector2.UP)


func _pick_up_item(body):
	player = body
	being_picked_up = true
