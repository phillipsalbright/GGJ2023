class_name BreakablePlatform
extends StaticBody2D

var help_i_am_dying = false

var velocity = Vector2.ZERO

export(int) var gravity = 200
export(int) var terminal_velocity = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if help_i_am_dying:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, terminal_velocity)
		
		position += velocity * delta
		
		# falls offscreen
		if global_position.y > 500:
			queue_free()


func step_on_branch():
	help_i_am_dying = true

