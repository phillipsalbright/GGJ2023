extends Actor

var air_boost = true
var hover = false

export(int) var air_boost_acceleration = 2500
export(int) var air_boost_speed = 500
export(int) var hover_speed = 200
export(int) var hover_fall_speed = 600
export(int) var hover_friction = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if is_on_floor() && $AirBoostDuration.time_left == 0:
		air_boost = true
		hover = false
	
	if !is_on_floor() && air_boost && Input.is_action_just_pressed("jump"):
		$AirBoostDuration.start()
		air_boost = false
	
	if $AirBoostDuration.time_left > 0:
		velocity.y = move_toward(velocity.y, -air_boost_speed, air_boost_acceleration * delta)
		sprite.modulate = Color(0.8, 1, 0.8, 1)
	elif hover:
		sprite.modulate = Color(1, 0.8, 0.8, 1)
		if Input.is_action_pressed("move_down"):
			velocity.y = move_toward(velocity.y, hover_fall_speed, hover_friction * delta)
		else:
			velocity.y = move_toward(velocity.y, hover_speed, hover_friction * delta)
	else:
		sprite.modulate = Color.white
	
	
	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		if collider is BreakablePlatform:
			collider.step_on_branch()


# Overriding parent apply_gravity
func apply_gravity(delta):
	if !is_on_floor() && $AirBoostDuration.time_left == 0 && !hover:
		velocity.y += gravity * delta
	velocity.y = min(terminal_velocity, velocity.y)
	
	snap_vector = Vector2.DOWN * snap_distance
	
	if $AirBoostDuration.time_left != 0:
		snap_vector = Vector2.ZERO


# Overriding parent short_hop
func short_hop():
	if Input.is_action_just_released("jump") && velocity.y < 0 && $AirBoostDuration.time_left == 0:
		velocity.y *= 0.6


func _on_AirBoostDuration_timeout():
	hover = true
