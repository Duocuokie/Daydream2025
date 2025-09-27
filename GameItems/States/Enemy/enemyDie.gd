extends State
class_name EnemyDie

@export var enemy : Enemy
@export var anim : AnimationPlayer
@export var enemyRoot : Node2D

@onready var camera = get_tree().current_scene.get_node("CameraMover") as camerMover


func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	enemy.emit_signal("enemyDied")

	anim.play("die")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	pass
		
		
func dieTime() -> void :
	enemyRoot.call_deferred("queue_free")
