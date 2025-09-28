class_name Enemy3 extends Enemy

@onready var hitbox = $Hitbox
@onready var health = $Health as healthComp
@onready var stateMachine := $StateMachine
@onready var enemyIdle = $StateMachine/enemyIdle as EnemyIdle
@onready var enemyMove = $StateMachine/enemyMove as EnemyMove
@onready var enemyDie = $StateMachine/enemyDie as EnemyDie
@onready var enemyHurt = $StateMachine/enemyHurt
@onready var sprite: Sprite2D = $Sprite2D

@export var enemy_die_particles : GPUParticles2D
@export var enemy_hurt_particles : GPUParticles2D

func _ready():
	enemyHurt.uptime.connect(stateMachine.change_state.bind(enemyMove))
func _physics_process(_delta):
	pass





func _on_hurtbox_area_entered(area : Area2D):
	if area.get_parent() is PlayerCharacter:
		area.get_parent().hitCount += 1
		hurterDir = (area.global_position - global_position).normalized()
		hurterPos = area.global_position
		enemyHurt.kbres = stats.kbRes
		enemyHurt.wkb = area.knockback
		if stateMachine.state != enemyDie:
			stateMachine.change_state(enemyHurt)
			enemy_hurt_particles.emitting = true
	else:
		print("sadf")
		hurterDir = (area.global_position - global_position).normalized()
		hurterPos = area.global_position
		enemyHurt.kbres = stats.kbRes
		enemyHurt.wkb = area.knockback/2
		if stateMachine.state != enemyDie:
			stateMachine.change_state(enemyHurt)
			enemy_hurt_particles.emitting = true
	

	
#func hits(hurtpos) -> void:
	#var Hit = hit.instantiate()
	#get_tree().current_scene.add_child(Hit)
	#Hit.global_position = global_position
	#var Parts = parts.instantiate()
	#get_tree().current_scene.add_child(Parts)
	#Parts.global_position = global_position
	#Parts.global_rotation = (global_position.angle_to_point(hurtpos))





func _on_health_die():
	enemy_die_particles.emitting = true
	hitbox.set_deferred("monitorable", false) 
	#hits(hurterPos)
	stateMachine.change_state(enemyDie)
