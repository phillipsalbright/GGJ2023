class_name Actor
extends KinematicBody2D

const gravity = 1500.0
const snap_distance = 10
const terminal_velocity = 500

export(bool) var is_player = true
export(int) var speed = 300
export(int) var jump_force = 600
export(int) var acceleration = 1500
export(int) var health = 50
export(int) var max_health = 50

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var snap_vector = Vector2.ZERO

onready var sprite = $Sprite


func _physics_process(delta):
	apply_gravity(delta)
	if is_player:
		get_input_direction()
	handle_movement(delta)


func apply_gravity(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	velocity.y = min(terminal_velocity, velocity.y)
	
	snap_vector = Vector2.DOWN * snap_distance


func get_input_direction():
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
		snap_vector = Vector2.ZERO
	
	short_hop()


func short_hop():
	if Input.is_action_just_released("jump") && velocity.y < 0:
		velocity.y *= 0.6


func handle_movement(delta):
	velocity.x = move_toward(velocity.x, direction.x * speed, delta * acceleration)
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true, 4, 0.8)


func handle_damage(damage):
	health -= damage
