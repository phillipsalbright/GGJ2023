extends Node2D
class_name GroundBossFightManager

var move_camera = false
var player_camera
var bush_locs
var rng = RandomNumberGenerator.new()
var boss_defeated = false


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	bush_locs= [$Bush.global_position, $Bush2.global_position, $Bush3.global_position]
	$GroundRabbit.global_position = $RabbitStorageLoc.global_position
	$GroundRabbit.set_state(0)
	$CanvasLayer/TextureProgress.visible = false
	$CanvasLayer/TextureProgress.max_value = $GroundRabbit.max_health
	$CanvasLayer/TextureProgress.value = $GroundRabbit.health
	pass # Replace with function body.


func _process(delta):
	if move_camera:
		var direction = ($BossCameraLocation.global_position - $Camera2D.global_position)
		if (direction.length() > 3):
			$Camera2D.global_position += direction.normalized() * delta * 270
	if boss_defeated:
		var direction = (player_camera.global_position - $Camera2D.global_position)
		if (direction.length() < 10):
			$Camera2D.global_position = player_camera.global_position
		else:
			$Camera2D.global_position += direction.normalized() * delta * 270


func _on_Area2D_body_entered(body):
	if body is GroundPlayer:
		move_camera = true
		$CanvasLayer/TextureProgress.visible = true
		$Camera2D.global_position =  get_parent().get_node("Player/Camera2D").global_position
		player_camera = get_parent().get_node("Player/Camera2D")
		$Camera2D.current = true
		get_node("BossTimer").start()
		$StaticBody2D3.global_position.y = -36
		$Area2D.disconnect("body_entered", $".", "_on_Area2D_body_entered")
	pass # Replace with function body.


func get_random_bush_location():
	return bush_locs[rng.randi_range(0, 2)]

func attack_over():
	$BetweenPhaseTimer.start()
	$GroundRabbit.global_position = $RabbitStorageLoc.global_position


func _on_BetweenPhaseTimer_timeout():
	$GroundRabbit.set_state(1)
	$BetweenPhaseTimer.stop()
	pass # Replace with function body.


func _on_BossTimer_timeout():
	move_camera = false
	$GroundRabbit.set_state(1)
	$BossTimer.stop()
	pass # Replace with function body.
	
func rabbit_death():
	$CanvasLayer/TextureProgress.visible = false
	boss_defeated = true
	$StaticBody2D4.queue_free()
	pass
