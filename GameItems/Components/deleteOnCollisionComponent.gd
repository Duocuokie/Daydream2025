extends Area2D
class_name deleteOnCollisionComponent

@export var actor : Entity
@export var pierce : int 


func _on_area_entered(_area: Area2D) -> void:
	updatePierce()
	

func _on_body_entered(_body: Node2D) -> void:
	updatePierce()

func updatePierce():
	pierce -= 1
	if pierce <= 0:
		set_deferred("monitorable", false)
		actor.call_deferred("queue_free")
