extends State
class_name EnemyIdle

@export var Bounce : bool = false

@export var enemy : Enemy 
@export var anim : AnimationPlayer




signal PlayerEnter

func _ready():
	set_physics_process(false)


	
func _enter_state() -> void:
	set_physics_process(true)
	anim.play("idle")
	enemy.global_position = enemy.global_position.snapped(Vector2(1, 1))

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, enemy.stats.friction * delta)
	enemy.move_and_slide()
		


func _on_area_detect_component_area_has_bodies() -> void:
	if is_physics_processing():
		emit_signal("PlayerEnter")
