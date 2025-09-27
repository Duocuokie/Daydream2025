class_name Player extends Node2D
#adsfesaf
func _physics_process(delta: float) -> void:
	%levelCamera.position = -Vector2(($PlayerCharacter.global_position - get_global_mouse_position())/8)
