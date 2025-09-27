extends State
class_name EnemyMove
@export var importantStats : Resource

@export var Bounce : bool = false

@export var enemy : Enemy
@export var anim : AnimationPlayer
@export var spr : Sprite2D

signal PlayerExit

func _ready():
	set_physics_process(false)
	
	

	
func _enter_state() -> void:
	set_physics_process(true)
	anim.play("move")


func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	var target = importantStats.PlayerPos
	if target != null:
		var directionToTarget = (target - enemy.global_position).normalized()
		enemy.velocity = enemy.velocity.move_toward(directionToTarget * enemy.stats.maxSpeed , enemy.stats.acceleration*delta)
		if Bounce:
			var collision = enemy.move_and_collide(enemy.velocity * delta)
			if collision:
				var bounce_velocity = (enemy.velocity.bounce(collision.get_normal()) + 4 * (directionToTarget * enemy.stats.maxSpeed))/5
				enemy.velocity = bounce_velocity
		else:
			enemy.move_and_slide()
		var lookdir = sign(enemy.global_position.direction_to(target)).x
		if lookdir != 0:
			spr.scale.x = lookdir
		else:
			spr.scale.x = 1
	else:
		emit_signal("PlayerExit")
		


func _on_area_detect_component_no_more_bodies() -> void:
	if is_physics_processing():
		emit_signal("PlayerExit")
