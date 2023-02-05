extends Node2D

const LOG = preload("res://src/water level/Log.tscn")


func _on_LogSpawner_timeout():
	var logg = LOG.instance()
	logg.global_position = Vector2(700, rand_range(118, 326))
	$YSort.add_child(logg)
