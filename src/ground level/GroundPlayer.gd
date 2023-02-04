extends Actor
class_name GroundPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fall_acceleration = -210
var roll_time = 0
var roll_damage_scale = .5
var roll_launch_scale = 450
var max_charge_time = 3
var launching_time = 1
var current_launch_timer = 0
var last_direction = -1
export(float) var damage_scalar = 10
var damage_to_deal = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#speed = 70
	get_node("Area2D").monitoring = false
	#jump_force = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y -= fall_acceleration * delta;
	var snap_vector = Vector2.ZERO
	if direction.x != 0:
		last_direction = sign(direction.x)
	
	
	if current_launch_timer > 0:
		current_launch_timer -= delta
		
	else:
		if current_launch_timer <= 0:
			get_node("Area2D").monitoring = false
			sprite.modulate = Color(1, .14, .96, 1)
		velocity.x = (direction.x) * speed
		if Input.is_action_pressed("special") and roll_time < max_charge_time:
			velocity.x = 0;
			roll_time += delta
			sprite.modulate = Color(1, 0, 0, 1)
		elif roll_time > 0:
			velocity.x = roll_time * roll_launch_scale * last_direction
			velocity.y = roll_time * roll_launch_scale * -.1
			sprite.modulate = Color(0, 1, 0, 1)
			current_launch_timer = launching_time
			get_node("Area2D").monitoring = true
			damage_to_deal = roll_time * damage_scalar
			roll_time = 0
#	pass

func _on_Area2D_area_entered(area):
	print_debug("floppy")
	
func handle_movement(delta):
	if (current_launch_timer > 0):
		velocity = move_and_slide(velocity)
	else:
		velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true, 4, 0.8)

func apply_gravity(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	velocity.y = min(terminal_velocity, velocity.y)
	
	snap_vector = Vector2.DOWN * snap_distance
	
func get_input_direction():
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_just_pressed("jump") && is_on_floor() && current_launch_timer <= 0:
		velocity.y = -jump_force
		snap_vector = Vector2.ZERO
	
	short_hop()


func _on_Area2D_body_entered(body):
	if body is GroundRabbit:
		body.handle_damage(damage_to_deal)
	if body is BreakableWall:
		body.handle_damage(damage_to_deal)
	if not body == self:
		
		current_launch_timer = 0
	print_debug(body)
	pass # Replace with function body.
