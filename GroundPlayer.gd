extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var fall_acceleration = -210
var speed = 70
var snapDist = 5000
var jump_force = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y -= fall_acceleration * delta;
	var snap_vector = Vector2.ZERO
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y -= jump_force
	else:
		snap_vector = Vector2.DOWN * snapDist;
	velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * speed
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true, 4, .8)
#	pass
