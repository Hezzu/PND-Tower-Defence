extends "res://Scenes/Enemies/EnemyMgr.gd"


func _ready():
	unit = "blackminiboss"
	maxHp = GameData.enemyData[unit]["hp"]
	armor = GameData.enemyData[unit]["armor"]
	hp = maxHp
	baseSpeed = GameData.enemyData[unit]["speed"]
	speed = baseSpeed
