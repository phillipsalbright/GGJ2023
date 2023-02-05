extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _on_Timer_timeout():
	get_tree().paused = true
	get_parent().get_node("WinScreen").visible = true
	get_parent().get_node("WinScreen").get_node("Button2")
