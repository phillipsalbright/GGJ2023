extends KinematicBody2D

const BULLET = preload("res://src/Bullet.tscn")

var velocity = Vector2.ZERO
var direction = Vector2.ZERO


onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var dist = global_position.distance_to(player.global_position)
	
	if dist > 500:
		direction = (player.global_position - global_position).normalized()
	elif dist < 300:
		direction = -(player.global_position - global_position).normalized()
	else:
		direction = Vector2.ZERO
	
	
	velocity = direction * 200
	move_and_slide(velocity)


func _on_ShootCountdown_timeout():
	var bullet = BULLET.instance()
	bullet.direction = (player.global_position - global_position).normalized()
	bullet.global_position = global_position
	get_parent().add_child(bullet)
