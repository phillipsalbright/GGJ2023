extends Area2D

var direction = Vector2.ZERO
var max_velocity = Vector2.ZERO

export(int) var wind_speed = 500
export(int) var wind_acceleration = 2500

func _ready():
	direction = Vector2.UP.rotated(deg2rad(rotation_degrees))
	max_velocity = direction * wind_speed


func _process(delta):
	for body in get_overlapping_bodies():
		if body is Actor:
			body.velocity += direction * wind_acceleration * delta
			if direction.x > 0.25:
				body.velocity.x = max(max_velocity.x, body.velocity.x)
			elif direction.x < -0.25:
				body.velocity.x = min(max_velocity.x, body.velocity.x)
				
			if direction.y > 0.25:
				body.velocity.y = min(max_velocity.y, body.velocity.y)
			elif direction.y < -0.25:
				body.velocity.y = max(max_velocity.y, body.velocity.y)
