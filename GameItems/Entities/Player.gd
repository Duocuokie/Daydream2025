extends Entity
class_name Player

#x


#movement variables

var maxSpeed : float = 125
var acceleration = 750
var friction = 1000

#getting hurt variables

var hurterPos : Vector2
@export var parts : PackedScene
@export var dieParts : PackedScene


#upperStuff



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

	
func _physics_process(_delta):
	pass
