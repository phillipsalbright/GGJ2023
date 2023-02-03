extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var fall_acceleration = -210;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y -= fall_acceleration * delta;
	if is_on_floor() and Input.is_action_pressed("Jump"):
		print_debug("frog")
		velocity.y -= 100
	velocity = move_and_slide(velocity, Vector2.UP)
#	pass
