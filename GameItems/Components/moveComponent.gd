extends Node
class_name moveComponent

@export var actor: Node2D
@export var velocity: Vector2
@export var speed : int

func _process(delta: float) -> void:
	actor.translate(velocity * delta)
