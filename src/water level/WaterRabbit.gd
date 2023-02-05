extends KinematicBody2D


const BULLET = preload("res://src/Bullet.tscn")

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var speed = 250

var lanes = [110, 210, 335, 210]
var lane_idx = 0

var pattern = 1

onready var player = get_tree().root.get_child(0).get_node("YSort/Player")

onready var timer = $ShootCountdown


# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackPatternTimer.start(20)


func _physics_process(delta):
	if pattern == 1:
		global_position.y = move_toward(global_position.y, lanes[lane_idx], speed * delta)
	else:
		if global_position.y <= 120:
			direction.y = 1
		elif global_position.y >= 320:
			direction.y = -1
		velocity = direction * speed
		velocity = move_and_slide(velocity)


func _on_ShootCountdown_timeout():
	var bullet = BULLET.instance()
	if pattern == 1:
		bullet.direction = Vector2(-1, 0)
	else:
		bullet.direction = (player.global_position - global_position).normalized()
	
	bullet.global_position = global_position
	player.get_parent().add_child(bullet)


func _on_MoveTimer_timeout():
	lane_idx = (lane_idx + 1) % 4


func _on_AttackPatternTimer_timeout():
	pattern += 1
	direction.y = -1
