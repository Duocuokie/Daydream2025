extends Control

@onready var music: TextureButton = $Music
@onready var sfx: TextureButton = $SFX
@onready var tutorial: CanvasLayer = $tutorial
@onready var slide_1: ColorRect = $tutorial/Slide1
@onready var slide_2: ColorRect = $tutorial/Slide2
@onready var slide_change: TextureButton = $tutorial/SlideChange



var Music = AudioServer.get_bus_index("Music")
var SFX = AudioServer.get_bus_index("SFX")

func _on_texture_button_pressed() -> void:
	SignalBus.playtime.emit()
	SignalBus.gameStart.emit()




func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_full_toggled(_toggled_on: bool) -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _ready() -> void:
	tutorial.visible = false
	music.button_pressed = AudioServer.is_bus_mute(Music)
	sfx.button_pressed = AudioServer.is_bus_mute(SFX)
func _on_sfx_toggled(_toggled_on: bool) -> void:
	AudioServer.set_bus_mute(SFX, !AudioServer.is_bus_mute(SFX))
func _on_music_toggled(_toggled_on: bool) -> void:
	AudioServer.set_bus_mute(Music, !AudioServer.is_bus_mute(Music))


func _on_tutorial_pressed() -> void:
	%Pause.visible = true
	tutorial.visible = true


func _on_close_pressed() -> void:
	%Pause.visible = false
	tutorial.visible = false

func _on_slide_change_pressed() -> void:
	slide_change.flip_h = !slide_change.flip_h
	slide_1.visible = !slide_1.visible
	slide_2.visible = !slide_2.visible
