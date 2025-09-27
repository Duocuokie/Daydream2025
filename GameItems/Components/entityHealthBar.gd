extends TextureProgressBar

@onready var anim = $AnimationPlayer
@onready var timer = $Timer

var barposses = [
	0,
	4,
	8
]


func  _ready():
	visible = false



func changecolour(vlue):
	texture_progress.region = Rect2(Vector2(2032,barposses[vlue]), Vector2(16, 4))
	


func _on_timer_timeout():
	anim.play("fade")



func _on_health_health_changed(health, maxHealth):
	value = (float(health)/maxHealth) * 100
	if value > 65:
		changecolour(0)
	elif value < 66 && value > 25:
		changecolour(1)
	else:
		changecolour(2)
	anim.play("show")
	timer.start(2)
	pass # Replace with function body.
