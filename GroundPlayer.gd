extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var fall_acceleration = -210
var speed = 70
var snapDist = 5000
var jump_force = 100
var roll_time = 0
var roll_damage_scale = .5
var roll_launch_scale = 220
var max_charge_time = 3
var launching_time = 1
var current_launch_timer = 0
var last_direction = -1
onready var sprite = get_node("CollisionShape2D/Sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y -= fall_acceleration * delta;
	var snap_vector = Vector2.ZERO
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction != 0:
		last_direction = sign(direction)
	
	
	if current_launch_timer > 0:
		current_launch_timer -= delta
		if current_launch_timer < 0:
			sprite.modulate = Color(1, 1, 1, 1)
	else:
		velocity.x = (direction) * speed
		if is_on_floor() and Input.is_action_pressed("jump"):
			velocity.y -= jump_force
		else:
			snap_vector = Vector2.DOWN * snapDist;
		if Input.is_action_pressed("special") and roll_time < max_charge_time:
			velocity.x = 0;
			roll_time += delta
			sprite.modulate = Color(1, 0, 0, 1)
		elif roll_time > 0:
			velocity.x = roll_time * roll_launch_scale * last_direction
			velocity.y = roll_time * roll_launch_scale * -.1
			sprite.modulate = Color(0, 1, 0, 1)
			current_launch_timer = launching_time
			roll_time = 0
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true, 4, .8)
#	pass




func _on_Area2D_area_entered(area):
	print_debug("floppy")
