extends State
class_name EnemyDie

@export var enemy : Enemy
@export var anim : AnimationPlayer




func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	enemy.emit_signal("enemyDied")
	SignalBus.enemyDie.emit(enemy.stats.score)
	anim.play("die")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	pass
		
		
func dieTime() -> void :
	enemy.call_deferred("queue_free")
