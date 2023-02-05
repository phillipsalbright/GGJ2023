extends StaticBody2D


export(int) var speed = 100


func _process(delta):
	position.x -= speed * delta
	
	if global_position.x < -100:
		queue_free()
