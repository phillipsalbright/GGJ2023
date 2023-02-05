extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = false;
var root

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree()
	visible = false
	pass # Replace with function body.

func player_wins():
	visible = true
	root.paused = true


func _on_Button2_pressed():
	get_tree().change_scene("res://src/Main.tscn")
	pass # Replace with function body.
