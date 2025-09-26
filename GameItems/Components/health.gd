extends Node2D
class_name healthComp


@export var maxHealth : int
@onready var health = maxHealth : set = setter

signal healthChanged(health, maxHealth)
signal die

func setter(value):
	health = value
	health = clamp(health, 0 , maxHealth)
	emit_signal("healthChanged", health, maxHealth)
	if health <= 0:
		emit_signal("die")
