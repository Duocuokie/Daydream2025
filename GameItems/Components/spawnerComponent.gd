extends Node2D
class_name SpawnerComponent



@export var scene: PackedScene

func spawn(global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node:
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = global_spawn_position
	return instance
