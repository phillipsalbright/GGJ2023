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


func _on_PlayGame_pressed():
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = true
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Water_Level_pressed():
	get_tree().change_scene("res://src/water level/WaterLevel.tscn")
	pass # Replace with function body.


func _on_Ground_Level_pressed():
	get_tree().change_scene("res://src/ground level/GroundLevel.tscn")
	pass # Replace with function body.


func _on_Air_Level_pressed():
	get_tree().change_scene("res://src/flying level/FlyingLevel.tscn")
	pass # Replace with function body.


func _on_Back_pressed():
	$CanvasLayer.visible = true
	$CanvasLayer2.visible = false
	pass # Replace with function body.
