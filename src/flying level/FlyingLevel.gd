extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SlowDownFire_body_entered(body):
	$Rabbit.timer.start(2)
	call_deferred("disable_slowdown")


func disable_slowdown():
	$SlowDownFire/CollisionShape2D.disabled = true