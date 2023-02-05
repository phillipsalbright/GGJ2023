extends KinematicBody2D


const BULLET = preload("res://src/Bullet.tscn")

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var speed = 250

var lanes = [140, 210, 280, 210]
var lane_idx = 0

onready var player = get_tree().root.get_child(0).get_node("YSort/Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_position.y = move_toward(global_position.y, lanes[lane_idx], speed * delta)


func _on_ShootCountdown_timeout():
	var bullet = BULLET.instance()
	#bullet.direction = (player.global_position - global_position).normalized()
	bullet.direction = Vector2(-1, 0)
	bullet.global_position = global_position
	player.get_parent().add_child(bullet)


func _on_MoveTimer_timeout():
	lane_idx = (lane_idx + 1) % 4
