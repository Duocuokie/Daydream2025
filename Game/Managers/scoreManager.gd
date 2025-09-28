extends Node2D

var Score = 0
var Combo = 0


var ComboString = "Combo x%s"

@onready var score: Label = $CanvasLayer/Score
@onready var combo: Label = $CanvasLayer/Combo
@onready var timer: Timer = $Timer
@onready var highscore: Label = $CanvasLayer/HighScore

@export var PlayerStats : Resource

func _ready() -> void:
	updateText()
	SignalBus.enemyDie.connect(updateScore)
	SignalBus.playerDie.connect(saveHighscore)
	
	
	var high = SignalBus.highscore
	highscore.text = str(high)
	set_process(false)
	
func _process(delta: float) -> void:
	Combo = clamp(floor(Combo - 5*delta), 0, 999999999)
	updateText()
	
func updateText():
	score.text = str(Score)
	combo.text = ComboString % str(Combo)
	
func updateScore(value):
	set_process(false)
	Combo += 1
	Score += floor(value * (1+(Combo/5)))
	updateText()
	timer.start()


func _on_timer_timeout() -> void:
	set_process(true)
	updateText()
	

func saveHighscore():
	var high = SignalBus.highscore
	if Score > high:
		var SaveGame = FileAccess.open("user://highscore", FileAccess.WRITE)
		SaveGame.store_32(Score)
	
	
