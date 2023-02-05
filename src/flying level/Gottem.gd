extends Area2D

onready var rabbit = get_parent().get_node("Rabbit")


func _on_DamnGottem_body_entered(body):
	$Label.show()
	$GottemTimer.start()


func _on_GottemTimer_timeout():
	rabbit.active = true
	rabbit.follow_player = true
	rabbit.get_node("ShootCountdown").start()
	$Label.hide()
	call_deferred("disable_col")


func disable_col():
	$CollisionShape2D.disabled = true
