extends Entity
class_name PlayerCharacter

#xasdafdds



#movement variables
@export var baseSpeed = 200
@export var baseAcceleration = 1750
@export var baseFriction = 2000

@export var sacSpeed = 350
@export var sacAcceleration = 2000
@export var sacFriction = 2500

@export var recoildAcceleration = 1000

var maxSpeed = baseSpeed
var acceleration = baseAcceleration
var friction = baseFriction

#getting hurt variables

var hurterPos : Vector2
var wasNotHolding := true


@export var bodyProj: BodyProj 
var isShot := false : set = isShotSetter
var charge := 0



#signals

signal playerDie
signal playerHit

#children

@onready var Anim = $AnimationPlayer
@onready var AnimTree = $AnimationTree
@onready var AnimTreeState = AnimTree.get("parameters/playback")
@onready var fsm = $StateMachine as StateMachine
@onready var playerMove = $StateMachine/playerMove as PlayerMove
@onready var playerIdle = $StateMachine/playerIdle as PlayerIdle



func _ready():
	AnimTree.set("parameters/Idle/blend_position", Vector2(0, 0.1))
	playerMove.idletime.connect(fsm.change_state.bind(playerIdle))
	playerIdle.runningtime.connect(fsm.change_state.bind(playerMove))
	bodyProj.bodyCollected.connect(func(): isShot = false)

	
func _physics_process(delta):
	#print(wasNotHolding)
	rotation = global_position.angle_to_point(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		if !isShot:
			if wasNotHolding:
				%Sprite2D.frame = 2
			charge += 100 * delta
		else:
			wasNotHolding = false
			velocity = velocity.move_toward(global_position.direction_to(bodyProj.global_position)* 1000, 5000*delta)
	if Input.is_action_just_released("shoot"):
		print(wasNotHolding)
		if !isShot :
			%Sprite2D.frame = 0
			if wasNotHolding:
				print(wasNotHolding, "shoot")
				isShot = true
				var direction = global_position.direction_to(get_global_mouse_position())
				bodyProj.shoot(global_position, direction, clamp(charge * 7 + 500, 0, 1200))
		
		
		charge = 0
		wasNotHolding = true

func _unhandled_input(_event: InputEvent) -> void:
	#shooting
	pass
func isShotSetter(value):
	isShot = value
	
	if value:
		%Sprite2D.frame = 1
		maxSpeed = sacSpeed
		acceleration = sacAcceleration
		friction = sacFriction
	else:
		%Sprite2D.frame = 0
		maxSpeed = baseSpeed
		acceleration = baseAcceleration
		friction = baseFriction
