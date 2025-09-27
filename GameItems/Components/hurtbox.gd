extends Area2D



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
	
	#if area.get_parent() is Projectile:
		#if area.get_parent().stats.pierce < 0:
			#piercing = false
		#else:
			#area.get_parent().stats.pierce -= 1
			
	if health.health > 0:
		startInvis(area.invis)
		health.health -= area.damage
