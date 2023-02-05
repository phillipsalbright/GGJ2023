extends Actor

var air_boost = true
var hover = false
var jump_takeoff = false

export(int) var air_boost_acceleration = 2000
export(int) var air_boost_speed = 500
export(int) var hover_speed = 200
export(int) var hover_fall_speed = 600
export(int) var hover_friction = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar/TextureProgress.max_value = max_health
	$HealthBar/TextureProgress.value = health


func _physics_process(delta):
	if is_on_floor() && $AirBoostDuration.time_left == 0:
		air_boost = true
		hover = false
	
	if !is_on_floor() && air_boost && Input.is_action_just_pressed("jump"):
		$AirBoostDuration.start()
		air_boost = false
	
	if $AirBoostDuration.time_left > 0:
		velocity.y = move_toward(velocity.y, -air_boost_speed, air_boost_acceleration * delta)
		$AnimationPlayer.play("float")
	elif hover:
		if Input.is_action_pressed("move_down"):
			velocity.y = move_toward(velocity.y, hover_fall_speed, hover_friction * delta)
			$AnimationPlayer.play("idle")
		else:
			velocity.y = move_toward(velocity.y, hover_speed, hover_friction * delta)
			$AnimationPlayer.play("jump")
	else:
		if jump_takeoff:
			$AnimationPlayer.play("take off")
		elif direction.x != 0 && is_on_floor():
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	
	
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


# overriding parent get input direction
func get_input_direction():
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
		snap_vector = Vector2.ZERO
		jump_takeoff = true
		$AnimationPlayer.play("take off")
	
	short_hop()


# Overriding parent short_hop
func short_hop():
	if Input.is_action_just_released("jump") && velocity.y < 0 && $AirBoostDuration.time_left == 0:
		velocity.y *= 0.6


func end_jump_takeoff():
	jump_takeoff = false
	hover = true


func _on_AirBoostDuration_timeout():
	hover = true


func handle_damage(damage):
	health -= damage
	$HealthBar/TextureProgress.value = health
	if health <= 0:
		$DeathMenu.player_died()
