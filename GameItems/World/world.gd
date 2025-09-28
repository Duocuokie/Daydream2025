extends Node2D

@export var world : Node2D
const WORLD = preload("uid://cwoxar3sgss1r")
var dead := false

var Music = AudioServer.get_bus_index("Music")
var SFX = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	SignalBus.playerDie.connect(playerDeath)

func playerDeath():
	print("die")
	get_tree().paused = true
	dead = true
	%Retry.visible = true

func retry():
	world.queue_free()
	var World = WORLD.instantiate()
	add_child(World)
	world = World
	%Retry.visible = false
	get_tree().paused = false
	
func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && !dead:
		get_tree().paused = !get_tree().paused
		%Pause.visible = !%Pause.visible
		
func _on_retry_button_pressed() -> void:
	retry()


func _on_music_pressed() -> void:
	AudioServer.set_bus_mute(Music, !AudioServer.is_bus_mute(Music))
	
func _on_sfx_pressed() -> void:
	AudioServer.set_bus_mute(SFX, !AudioServer.is_bus_mute(SFX))

func _on_quit_pressed() -> void:
	get_tree().paused = false
	SignalBus.gameMenu.emit()
