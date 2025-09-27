class_name SoftCollision extends Area2D

@export var actor : CharacterBody2D

var isColliding := false
var collidingArea : SoftCollision

func _on_area_entered(area: SoftCollision) -> void:
	collidingArea = area
	isColliding = true
	


func _on_area_exited(_area: Area2D) -> void:
	isColliding = false

func _physics_process(delta: float) -> void:
	if isColliding:
		var direction = collidingArea.actor.global_position.direction_to(actor.global_position)
		actor.velocity = actor.velocity.move_toward(direction*100 + actor.velocity, 2700 * delta) 
