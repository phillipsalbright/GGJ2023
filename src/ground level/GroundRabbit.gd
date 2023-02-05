extends Actor

class_name GroundRabbit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 0
const BULLET = preload("res://src/Bullet.tscn")
onready var player = get_parent().get_parent().get_node("Player")
var bush_loc
var local_timer = 0
var reset_timer = 0
var player_target = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match (state):
		0:
			$BulletTimer.paused = true
			pass
		1:
			$BulletTimer.paused = true
			global_position = get_parent().get_random_bush_location()
			velocity = Vector2.ZERO
			bush_loc = global_position
			state = 2
			pass
		2:
			$PhaseTimer.start(5)
			$BulletTimer.paused = false
			$BulletTimer.start()
			state = 3
		3:
			pass
		4:
			var ydist = abs(global_position.y - player.global_position.y)
			local_timer = 0
			print_debug(ydist)
			if ydist < 50:
				state = 5
				player_target = sign(player.global_position.x - global_position.x)
			else:
				$BulletTimer.wait_time = .4
				state = 6
		5:
			$BulletTimer.stop()
			local_timer += delta
			velocity.x = player_target * speed
			$Area2D.monitoring = true
			if local_timer > 2.9:
				velocity = Vector2.ZERO
				state = 7
				reset_timer = 0
			pass
		6:
			local_timer += delta
			if local_timer > 5:
				state = 7
				reset_timer = 0
				$BulletTimer.wait_time = 1
		7:
			reset_timer += delta
			$BulletTimer.paused = true
			$PhaseTimer.stop()
			var directionx = (bush_loc.x - global_position.x)
			if (abs(directionx) < 3):
				direction = (bush_loc - global_position).normalized()
				direction.y *= jump_force
				velocity = direction
			else:
				direction.x = sign(directionx)
				direction.y = 0
				velocity = direction * speed
			if ((bush_loc - global_position).length() < 10):
				velocity = Vector2.ZERO
				$Area2D.monitoring = false
				state = 8
			if (reset_timer > 5):
				state = 8
		8:
			get_parent().attack_over()
			velocity = Vector2.ZERO
			state = 0
		_:
			pass

func set_state(state_change):
	state = state_change
	

func handle_damage(damage):
	health -= damage
	print_debug(health)
	get_parent().get_node("CanvasLayer/ProgressBar").value = health
	if (health < 0):
		get_parent().rabbit_death()
		queue_free()


func _on_BulletTimer_timeout():
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.direction = (player.global_position - global_position).normalized()
	bullet.global_position = global_position
	pass # Replace with function body.


func _on_PhaseTimer_timeout():
	state = 4
	$PhaseTimer.stop()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print_debug("HIT")
	body.handle_damage(15)
	state = 7
	
func handle_movement(delta):
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true, 4, 0.8)
