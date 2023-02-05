extends Actor

class_name GroundRabbit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 0
const BULLET = preload("res://src/Bullet.tscn")
onready var player = get_parent().get_parent().get_node("Player")
var bush_loc


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
			bush_loc = global_position
			print_debug(bush_loc)
			state = 2
			pass
		2:
			$PhaseTimer.start(10)
			$BulletTimer.paused = false
			$BulletTimer.start()
			state = 3
		3:
			pass
		4:
			$BulletTimer.paused = true
			$PhaseTimer.stop()
			direction = (bush_loc - global_position)
			if (direction.length() < 1):
				state = 5
			print(direction.length())
			velocity = direction.normalized() * 200
			move_and_slide(velocity)
		5:
			get_parent().attack_over()
			velocity = Vector2.ZERO
			state = 0
		_:
			pass

func set_state(state_change):
	print_debug(state)
	state = state_change
	

func handle_damage(damage):
	health -= damage
	print_debug(health)
	if (health < 0):
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
