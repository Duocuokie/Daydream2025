extends Entity
class_name PlayerCharacter

#xasdafdds

@export var importantStats : Resource

#movement variables
@export var baseSpeed := 200
@export var baseAcceleration := 1750
@export var baseFriction := 2000

@export var sacSpeed := 350
@export var sacAcceleration := 2000
@export var sacFriction := 2500

@export var recoildAcceleration := 1000

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
@onready var shoot_particles: GPUParticles2D = $Particles/ShootParticles
@onready var hurt_particle: GPUParticles2D = $Particles/HurtParticle

func _ready():
	AnimTree.set("parameters/Idle/blend_position", Vector2(0, 0.1))
	playerMove.idletime.connect(fsm.change_state.bind(playerIdle))
	playerIdle.runningtime.connect(fsm.change_state.bind(playerMove))
	bodyProj.bodyCollected.connect(func(): isShot = false)

	
func _physics_process(delta):
	#print(wasNotHolding)
	importantStats.PlayerPos = global_position
	rotation = global_position.angle_to_point(get_global_mouse_position())
	if Input.is_action_pressed("shoot"): 
		if !isShot: # AIMING
			if wasNotHolding:
				%Sprite2D.frame = 2
			charge += 100 * delta
		else: # RECOLLECTING
			wasNotHolding = false
			velocity = velocity.move_toward(global_position.direction_to(bodyProj.global_position)* 1000, 5000*delta)
			%Sprite2D.frame = 3
	if Input.is_action_just_released("shoot"):
		if !isShot: # RECOLLECTED ALREADY, FAKE SHOOT
			%Sprite2D.frame = 0
			if wasNotHolding:
				isShot = true
				var direction = global_position.direction_to(get_global_mouse_position())
				bodyProj.shoot(global_position, direction, clamp(charge * 7 + 500, 0, 1200))
		else: # SHOT
			$Sprite2D.frame = 1
			shoot_particles.emitting = true
		
		charge = 0
		wasNotHolding = true

func _unhandled_input(_event: InputEvent) -> void:
	#shooting
	pass
func isShotSetter(value):
	isShot = value
	
	if value:
		%Sprite2D.frame = 1
		%RecoilTimer.stop()
		maxSpeed = sacSpeed
		acceleration = sacAcceleration	
		friction = sacFriction
	else:
		%Sprite2D.frame = 0
		maxSpeed = baseSpeed
		acceleration = recoildAcceleration
		friction = baseFriction
		%RecoilTimer.start()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	hurterPos = area.global_position
	%Flash.play("flash", 0, 1/area.invis)


func _on_recoil_timer_timeout() -> void:
	acceleration = baseAcceleration
