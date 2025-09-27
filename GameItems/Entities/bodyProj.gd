class_name BodyProj extends CharacterBody2D

signal bodyCollected

var friction := 1500
var collected := true
@onready var timer: Timer = $Timer
@onready var collectArea: Area2D = $CollectArea

func _ready() -> void:
	set_physics_process(false)
	visible = false
	

func shoot(pos, direction, speed) -> void:
	set_physics_process(true)
	timer.start()
	collectArea.monitoring = false
	visible = true
	global_position = pos
	velocity = direction * speed
	
func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		set_physics_process(false)
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()
	


func _on_collect_area_body_entered(_body: Node2D) -> void:
	set_physics_process(false)
	visible = false
	bodyCollected.emit()


func _on_timer_timeout() -> void:
	collectArea.monitoring = true
