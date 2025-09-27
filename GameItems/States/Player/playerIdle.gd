extends State
class_name PlayerIdle


@export var player : Player
@export var animTree : AnimationTree

signal runningtime

func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	print("idle")
	set_physics_process(true)
	player.global_position = player.global_position.snapped(Vector2(1, 1))

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.friction * delta)
	player.AnimTreeState.travel("Idle")
	var inputVector = Vector2.ZERO
	inputVector = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if inputVector != Vector2.ZERO:
		emit_signal("runningtime")
	player.move_and_slide()
