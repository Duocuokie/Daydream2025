extends Control

@onready var music: TextureButton = $Music
@onready var sfx: TextureButton = $SFX
@onready var tutorial: CanvasLayer = $tutorial



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
