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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if paused:
			visible = false
			root.paused = false
		else:
			visible = true
			root.paused = true
			$Button.grab_focus()
	pass


func _on_Button_pressed():
	visible = false
	root.paused = false
	pass # Replace with function body.


func _on_Button2_pressed():
	root.paused = false
	get_tree().change_scene("res://src/Main.tscn")
	pass # Replace with function body.
