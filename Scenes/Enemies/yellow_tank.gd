extends "res://Scenes/Enemies/EnemyMgr.gd"

func _ready():
	unit = "yellowtank"
	maxHp = GameData.enemyData[unit]["hp"]
	hp = maxHp
	baseSpeed = GameData.enemyData[unit]["speed"]
	speed = baseSpeed
