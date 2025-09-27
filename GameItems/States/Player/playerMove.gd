extends State
class_name PlayerMove


@export var player : Player
@export var animTree : AnimationTree

signal idletime

func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	print("move")
	set_physics_process(true)

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	inputVector = inputVector.normalized()
	if inputVector != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(inputVector * player.maxSpeed, player.acceleration * delta)
		player.move_and_slide()
		animTree.set("parameters/Idle/blend_position", inputVector)
		animTree.set("parameters/Run/blend_position", inputVector)
		player.AnimTreeState.travel("Run")
		
	else:
		emit_signal("idletime")
	
