extends Node


signal playerHurt
signal playerDie

signal enterRoom(room : Room)
signal clearRoom(room : Room)

signal enemyDie(enemy)

signal towerDie(tower)
signal towerSpawn(tower)
signal towerSwap(tower)


func StopGivingMeErrors():
	playerHurt.emit()
	playerDie.emit()
	enterRoom.emit()
	clearRoom.emit()
	enemyDie.emit()
	towerDie.emit()
	towerSpawn.emit()
	towerSwap.emit()
	
