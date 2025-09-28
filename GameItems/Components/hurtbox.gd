extends Area2D


@export var resist := 0
var invis = false : set = setInvis
@onready var timer = $Timer
 
@export var health : healthComp


var hurterPos : Vector2


func setInvis(value):
	invis = value
	if invis == true:
		emit_signal("invisStart")
	else:
		emit_signal("invisEnd")

signal invisStart
signal invisEnd

func startInvis(duration):
	self.invis = true
	timer.start(duration)


func _on_Timer_timeout():
	self.invis = false


func _on_hurtBox_invisStart():
	set_deferred("monitoring", false)


func _on_hurtBox_invisEnd():
	monitoring = true




func _on_area_entered(area):
	if resist == 0:
		if health.health > 0:
			startInvis(area.invis)
			health.health -= area.damage
	elif resist == 1:
		if area.get_parent() is PlayerCharacter:
			startInvis(area.invis)
			health.health -= area.damage
	elif resist == 2:
		if area.get_parent() is BodyProj:
			startInvis(area.invis)
			health.health -= area.damage
	elif resist == 3:
		if area.get_parent() is Enemy4:
			startInvis(area.invis)
			health.health -= area.damage
