extends KinematicBody2D

const BULLET = preload("res://src/Bullet.tscn")

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var speed = 250


onready var player = get_tree().root.get_child(0).get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var dist = global_position.distance_to(player.global_position)
	var dir = (player.global_position - global_position).normalized()
	
	global_position.y = move_toward(global_position.y, player.global_position.y - 150, speed * delta)
	
	if dist > 250:
		direction.x = dir.x
	else:
		direction = Vector2.ZERO
	
	
	velocity = direction * speed
	move_and_slide(velocity)


func _on_ShootCountdown_timeout():
	var bullet = BULLET.instance()
	bullet.direction = (player.global_position - global_position).normalized()
	bullet.global_position = global_position
	get_parent().add_child(bullet)
