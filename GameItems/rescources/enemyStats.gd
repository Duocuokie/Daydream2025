extends Resource
class_name EnemyStats

@export var maxSpeed : int
@export var acceleration : int
@export var friction : int

@export var maxHp : int
@export var baseDamage : int
@export var kbRes : float

# modifiers

var Mspd : float = 1.0
var Macl : float = 1.0
var Mfct : float = 1.0

var Mmhp : float = 1.0
var Mdmg : float = 1.0
var Mkbr : float = 1.0
