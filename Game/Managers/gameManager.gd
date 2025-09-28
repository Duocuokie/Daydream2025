extends Node

@onready var scene2d: Node2D = %Scene2D
var current2D

const MENU = preload("res://Game/Menu.tscn")
const GAME = preload("res://GameItems/World/2dGame.tscn")


func _ready() -> void:
	current2D = scene2d.get_child(0)
	SignalBus.gameStart.connect(switch2DScene.bind(GAME))

#Switches to a new scene and deletes old one
func switch2DScene(newPackedScene : PackedScene) -> void:
	var NewScene = newPackedScene.instantiate()
	current2D.queue_free()
	scene2d.add_child(NewScene)
	current2D = scene2d.get_child(0)
	
func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
