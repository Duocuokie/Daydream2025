extends Resource
class_name PlayerStats

@export var maxSpeed : float = 125
@export var acceleration = 750
@export var friction = 1000

@export var maxHp : int

var playerPos : Vector2

# 0 weapon mode 1 tower mode 2 disabled
var weapons = {
	"stick" = 0
}
