extends KinematicBody2D


var lane = 2
var lane_positions = [95, 159, 225]

var jumping = false

export(int) var horizontal_speed = 100
export(int) var change_lane_speed = 200
export(int) var jump_force = 110
export(int) var gravity = 200

var direction = Vector2.ZERO
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("swim")
	
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if $AnimationPlayer.current_animation == "swim":
		if Input.is_action_just_pressed("up_lane") && lane > 1:
			lane -= 1
		if Input.is_action_just_pressed("down_lane") && lane < 3:
			lane += 1
		
		if global_position.y == lane_positions[lane - 1]:
			if Input.is_action_just_pressed("special"):
				$AnimationPlayer.play("dive")
			
			if Input.is_action_just_pressed("jump"):
				$AnimationPlayer.play("jump")
				jumping = true
				velocity.y = -jump_force
			
	if abs(global_position.y - lane_positions[lane - 1]) < 5:
		if jumping && velocity.y > 0:
			jumping = false
			$AnimationPlayer.play("swim")
		elif !jumping:
			global_position.y = lane_positions[lane - 1]
	
	direction.y = sign(lane_positions[lane - 1] - global_position.y)
		
	if $AnimationPlayer.current_animation == "dive":
		direction = Vector2.ZERO
	
	if !jumping:
		velocity.x = direction.x * horizontal_speed
		velocity.y = direction.y * change_lane_speed
	else:
		velocity.y += gravity * delta
	
	move_and_slide(velocity)
