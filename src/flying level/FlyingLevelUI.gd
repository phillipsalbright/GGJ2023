extends CanvasLayer

onready var player = get_tree().root.get_child(0).get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HPLabel.text = "HP: " + str(player.health)
