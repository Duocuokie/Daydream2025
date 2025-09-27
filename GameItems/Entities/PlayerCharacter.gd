extends Entity
class_name PlayerCharacter

#x



#movement variables
@export var baseSpeed = 250
@export var baseAcceleration = 1750
@export var baseFriction = 2500

@export var sacSpeed = 350
@export var sacAcceleration = 2000
@export var sacFriction = 2000

var maxSpeed = baseSpeed
var acceleration = baseAcceleration
var friction = baseFriction

#getting hurt variables

var hurterPos : Vector2


@export var bodyProj: BodyProj 
var isShot := false : set = isShotSetter



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

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		if !isShot:
			isShot = true
			var direction = global_position.direction_to(get_global_mouse_position())
			bodyProj.shoot(global_position, direction, 1000)
	
func _physics_process(_delta):
	rotation = global_position.angle_to_point(get_global_mouse_position())
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
