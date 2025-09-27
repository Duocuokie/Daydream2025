extends State
class_name EnemyHurt

@export var enemy : Enemy
@export var anim : AnimationPlayer


var wkb : int
var kbres : float

@onready var camera = get_tree().current_scene.get_node("CameraMover") as camerMover

@export var Bounce : bool = false



signal uptime

func _ready():
	set_physics_process(false)
 
	
	
func _enter_state() -> void:
	set_physics_process(true) 
	anim.play("hit")
	enemy.emit_signal("enemyHit")
	enemy.velocity = enemy.hurterDir * wkb * kbres * -1
	

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, enemy.stats.friction * delta)
	if !anim.is_playing():
		emit_signal("uptime")
	if Bounce:
		var collision = enemy.move_and_collide(enemy.velocity * delta)
		if collision:
			var bounce_velocity : Vector2
			var target = Vector2.ZERO
			if target != null:
				var directionToTarget = (target.global_position - enemy.global_position).normalized()
				var mag : float = enemy.velocity.length()
				bounce_velocity =  (3 *(directionToTarget * mag) + enemy.velocity.bounce(collision.get_normal()))/4
				bounce_velocity = bounce_velocity.normalized() * mag
			else: bounce_velocity = enemy.velocity.bounce(collision.get_normal())
			enemy.velocity = bounce_velocity
	else:
		enemy.move_and_slide()
