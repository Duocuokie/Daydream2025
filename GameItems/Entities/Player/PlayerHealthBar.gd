extends TextureProgressBar

@export var health : healthComp

var barposses = [
	64,
	32,
	0
]
func _ready():
	health.healthChanged.connect(_on_health_comp_health_changed)
	changecolour(0)

func _on_health_comp_health_changed(hp, maxHealth):
	value = (float(hp)/maxHealth) * 100
	if value >= 65:
		changecolour(0)
	elif value < 65 && value > 25:
		changecolour(1)
	else:
		changecolour(2)
	
func changecolour(valu):
	texture_progress.region = Rect2(Vector2(1904,barposses[valu]), Vector2(128, 32))
