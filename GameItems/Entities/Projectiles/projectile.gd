extends Entity
class_name Projectile

@export var stats : ProjStats
@onready var hitbox: Hitbox = $Hitbox

@onready var move: moveComponent = $moveComponent
@export var deleteCol: deleteOnCollisionComponent

func  _ready() -> void:
	hitbox.damage = stats.damage
	hitbox.invis = stats.invis
	hitbox.knockback = stats.knockback
	hitbox.inflictStatus = stats.inflictStatus
	if deleteCol:
		deleteCol.pierce = stats.pierce

func _on_hitbox_area_entered(_area: Area2D) -> void:
	queue_free()
 
