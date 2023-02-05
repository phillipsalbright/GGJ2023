extends Actor
class_name GroundPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fall_acceleration = -210
var roll_time = 0
var roll_damage_scale = .8
var roll_launch_scale = 570
var max_charge_time = 1.8
var launching_time = 1
var current_launch_timer = 0
var last_direction = -1
export(float) var damage_scalar = 20.0
var damage_to_deal = 0
var hurt_time = 0
var cooldownTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#speed = 70
	get_node("Area2D").monitoring = false
	$HealthBar/ProgressBar.max_value = max_health
	$HealthBar/ProgressBar.value = health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y -= fall_acceleration * delta;
	if direction.x != 0:
		last_direction = sign(direction.x)
	if hurt_time > 0:
		hurt_time -= delta
		if hurt_time <= 0:
			$AnimationPlayer2.play("RESET")
	cooldownTimer -= delta
	if current_launch_timer > 0:
		current_launch_timer -= delta
		
	else:
		if current_launch_timer <= 0:
			get_node("Area2D").monitoring = false
			if (is_on_floor() and direction.x != 0):
				$AnimationPlayer.play("Walk")
			elif is_on_floor():
				$AnimationPlayer.play("Idle")
		velocity.x = (direction.x) * speed
		if Input.is_action_pressed("special") and roll_time < max_charge_time and cooldownTimer <= 0:
			velocity.x = direction.x * speed * .1;
			roll_time += delta
			$AnimationPlayer.play("Charging")
		elif roll_time > 0:
			velocity.x = (roll_time + .2) * roll_launch_scale * last_direction
			velocity.y = roll_time * roll_launch_scale * -.1
			$AnimationPlayer.play("Running")
			current_launch_timer = roll_time + .2
			get_node("Area2D").monitoring = true
			damage_to_deal = roll_time * damage_scalar
			cooldownTimer = current_launch_timer + .5
			roll_time = 0
#	pass

func _on_Area2D_area_entered(area):
	pass
	
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
		$AnimationPlayer.play("Jump")
		snap_vector = Vector2.ZERO
	if current_launch_timer <= 0:
		if direction.x > 0:
			sprite.flip_h = false
		elif direction.x < 0:
			sprite.flip_h = true
	
	short_hop()


func _on_Area2D_body_entered(body):
	if body is GroundRabbit:
		body.handle_damage(damage_to_deal)
	if body is BreakableWall:
		print_debug(damage_to_deal)
		body.handle_damage(damage_to_deal)
	if not body == self:
		current_launch_timer = 0
	pass # Replace with function body.
	
func handle_damage(damage):
	if (hurt_time <= 0):
		health -= damage
		$AnimationPlayer2.play("Hurt")
		hurt_time = 2
		if (health <= 0):
			$DeathScreen.player_died()
	$HealthBar/ProgressBar.value = health
	
