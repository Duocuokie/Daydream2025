extends Node


signal playerShot
signal bodyCollected
signal playerDie
signal enemyDie
signal playtime

static var highscore := 0

func _ready() -> void:
	SignalBus.playtime.connect(getHigh)
	
func getHigh():
	var f = FileAccess.open("user://highscore", FileAccess.READ)
	if f !=null:
		highscore = f.get_32()
	else:
		highscore = 0
	return highscore


func StopGivingMeErrors():
	pass
