extends Node2D

@export var world : Node2D
const WORLD = preload("uid://cwoxar3sgss1r")

func _ready() -> void:
	SignalBus.playerDie.connect(playerDeath)

func playerDeath():
	print("die")
	get_tree().paused = true
	%Retry.visible = true

func retry():
	world.queue_free()
	var World = WORLD.instantiate()
	add_child(World)
	world = World
	%Retry.visible = false
	get_tree().paused = false
	


func _on_retry_button_pressed() -> void:
	retry()
