extends CanvasLayer

func _ready():
	$Button.grab_focus()


func _on_Button_pressed():
	get_tree().change_scene("res://src/water level/WaterLevel.tscn")
