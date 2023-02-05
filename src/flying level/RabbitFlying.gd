extends KinematicBody2D

const BULLET = preload("res://src/Bullet.tscn")

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var speed = 250

var follow_player = false
var active = false


onready var player = get_tree().root.get_child(0).get_node("Player")
onready var timer = $ShootCountdown

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if follow_player:
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
	if active:
		var bullet = BULLET.instance()
		bullet.direction = (player.global_position - global_position).normalized().rotated(rand_range(-0.2, 0.2))
		bullet.global_position = global_position
		bullet.SPEED = 300
		get_parent().add_child(bullet)
