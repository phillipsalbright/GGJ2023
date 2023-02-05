extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = false;
var root

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree()
	print_debug(root)
	visible = false
	pass # Replace with function body.

func player_died():
	visible = true
	root.paused = true
	$Button.grab_focus()


func _on_Button_pressed():
	root.paused = false
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Button2_pressed():
	root.paused = false
	get_tree().change_scene("res://src/Main.tscn")
	pass # Replace with function body.
