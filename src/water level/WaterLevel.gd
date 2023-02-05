extends Node2D

const LOG = preload("res://src/water level/Log.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _on_LogSpawner_timeout():
	var logg = LOG.instance()
	logg.global_position = Vector2(700, rng.randf_range(118, 326))
	$YSort.add_child(logg)


func _on_LogIncrease_timeout():
	$LogSpawner.start(1)
	$YSort/Rabbit.timer.start(0.15)
