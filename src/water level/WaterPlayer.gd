class_name WaterPlayer
extends KinematicBody2D


# Variables to simulate sprite jumping
var jumping = false
var storey = 0
var spritev = 0

var health = 100
var max_health = 100

export(int) var speed = 150
export(int) var jump_force = 250
export(int) var gravity = 600

var direction = Vector2.ZERO
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar/TextureProgress.max_value = max_health
	$HealthBar/TextureProgress.value = health
	pass # Replace with function body.


func _physics_process(delta):
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("swim")
	
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if $AnimationPlayer.current_animation == "swim":
		if Input.is_action_just_pressed("special"):
			$AnimationPlayer.play("dive")
		
		if Input.is_action_just_pressed("jump"):
			$AnimationPlayer.play("jump")
			$JumpSound.play()
			jumping = true
			spritev = -jump_force
			storey = $Sprite.position.y
			
	if abs($Sprite.position.y - storey) < 5 && jumping && spritev > 0:
		jumping = false
		$AnimationPlayer.play("swim")
		$Sprite.position.y = storey
	
	if !jumping:
		velocity = direction.normalized() * speed
	else:
		spritev += gravity * delta
		$Sprite.position.y += spritev * delta
		#velocity.y += gravity * delta
	
	move_and_slide(velocity)


func handle_damage(damage):
	health -= damage
	$HealthBar/TextureProgress.value = health
	if (health <= 0):
		$DeathMenu.player_died()
	
	$HurtSound.play()
