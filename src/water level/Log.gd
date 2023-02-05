extends Area2D


export(int) var speed = 100


func _process(delta):
	position.x -= speed * delta
	
	if global_position.x < -100:
		queue_free()


func _on_Log_body_entered(body):
	if body is WaterPlayer:
		body.handle_damage(10)
		queue_free()
