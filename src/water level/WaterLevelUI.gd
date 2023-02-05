extends CanvasLayer

onready var player = get_tree().root.get_child(0).get_node("YSort/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Timer_timeout():
	$WinText.show()
