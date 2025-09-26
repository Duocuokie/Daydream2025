extends Node

@onready var scene2d: Node2D = %Scene2D
var current2D : Node2D

func _ready() -> void:
	current2D = scene2d.get_child(0)

#Switches to a new scene and deletes old one
func switch2DScene(newPackedScene : PackedScene) -> void:
	var NewScene = newPackedScene.instantiate()
	current2D.queue_free()
	scene2d.add_child(NewScene)
	current2D = scene2d.get_child(0)
	
	
