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

@export var slowSpeed = 125

@export var recoildAcceleration := 1000

var maxSpeed = baseSpeed
var acceleration = baseAcceleration
var friction = baseFriction

#getting hurt variables

var hurterPos : Vector2
var hurterDir : Vector2
var wasNotHolding := true
var hitCount := 0 : set = hitCountSetter


@export var bodyProj: BodyProj 
var isShot := false : set = isShotSetter
var charge := 0
var startBuffer := true


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
@onready var hurt_particles: GPUParticles2D = $Particles/HurtParticles
@onready var nostate: Node = $StateMachine/nostate

func _ready():
	AnimTree.set("parameters/Idle/blend_position", Vector2(0, 0.1))
	playerMove.idletime.connect(fsm.change_state.bind(playerIdle))
	playerIdle.runningtime.connect(fsm.change_state.bind(playerMove))
	bodyProj.bodyCollected.connect(func(): isShot = false)

	
func _physics_process(delta):
	#print(wasNotHolding)
	if velocity.length_squared() > 150000:
		%Hitbox.set_deferred("monitorable", true)
		%Hurtbox.set_deferred("monitoring", false)
	else:
		%Hitbox.set_deferred("monitorable", false)
		%Hurtbox.set_deferred("monitoring", true)
	
	importantStats.PlayerPos = global_position
	var mouseRad = global_position.angle_to_point(get_global_mouse_position())
	rotation = mouseRad
	if Input.is_action_pressed("shoot"): 
		if bodyProj.hasHit: # RECOLLECTING
			wasNotHolding = false
			velocity = velocity.move_toward(global_position.direction_to(bodyProj.global_position)* 900, 5000*delta)
			%Sprite2D.frame = 3
		elif !isShot:
			if wasNotHolding:
				%Sprite2D.frame = 2
				charge += 100 * delta
				maxSpeed = slowSpeed
			else:
				maxSpeed = baseSpeed
	if Input.is_action_just_released("shoot"):
		if !isShot && !startBuffer: 
			%Sprite2D.frame = 0
			if wasNotHolding: # SHOOT
				isShot = true
				shoot_particles.emitting = true
				var direction = global_position.direction_to(get_global_mouse_position())
				bodyProj.shoot(global_position, direction, clamp(charge * 6 + 450, 0, 1100))
				velocity = velocity + -Vector2.from_angle(mouseRad).normalized() * 640
			else: # FAKE SHOT
				pass
		else: # ON THE WAY
			$Sprite2D.frame = 1
		
		charge = 0
		wasNotHolding = true

func _unhandled_input(_event: InputEvent) -> void:
	#shooting
	pass

func hitCountSetter(value):
	hitCount = value
	if value > 3:
		%Health.health += clamp(1 * hitCount, 0, 10)
	
func isShotSetter(value):
	isShot = value
	
	if value:
		%Sprite2D.frame = 1
		%RecoilTimer.stop()
		maxSpeed = sacSpeed
		acceleration = sacAcceleration	
		friction = sacFriction
	else:
		hitCount = 0
		%Sprite2D.frame = 0
		maxSpeed = baseSpeed
		acceleration = recoildAcceleration
		friction = baseFriction
		%RecoilTimer.start()


func _on_hurtbox_area_entered(area: Hitbox) -> void:
	print(%Health)
	if %Health.health > 0 && isShot:
		%Health.health -= area.damage
	hurterPos = area.global_position
	hurterDir = (area.global_position - global_position).normalized()
	velocity = hurterDir * area.knockback * -1
	hurt_particles.emitting = true
	%Flash.play("flash", 0, 1/area.invis)



func _on_recoil_timer_timeout() -> void:
	acceleration = baseAcceleration


func _on_health_die() -> void:
	print("die")
	SignalBus.playerDie.emit()
	fsm.change_state(nostate)


func _on_start_timer_timeout() -> void:
	startBuffer = false
