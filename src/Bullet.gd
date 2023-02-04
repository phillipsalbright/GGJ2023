extends Area2D


var direction = Vector2.ZERO

var SPEED = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(global_position + direction)


func _process(delta):
	position += direction * SPEED * delta


func _on_Lifetime_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	queue_free()
