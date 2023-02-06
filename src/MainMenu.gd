extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/PlayGame.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayGame_pressed():
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = true
	$CanvasLayer2/Back.grab_focus()
	$ButtonSound.play()
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	$ButtonSound.play()
	pass # Replace with function body.


func _on_Water_Level_pressed():
	get_tree().change_scene("res://src/water level/WaterTutorial.tscn")
	pass # Replace with function body.


func _on_Ground_Level_pressed():
	get_tree().change_scene("res://src/ground level/GroundTutorial.tscn")
	pass # Replace with function body.


func _on_Air_Level_pressed():
	get_tree().change_scene("res://src/flying level/FlyingTutorial.tscn")
	pass # Replace with function body.


func _on_Back_pressed():
	$CanvasLayer.visible = true
	$CanvasLayer2.visible = false
	$CanvasLayer/PlayGame.grab_focus()
	$ButtonSound.play()
	pass # Replace with function body.
