extends "res://Scenes/SupportScenes/test_EnemyMgr.gd"

func _ready():
	unit = "greentank"
	maxHp = GameData.enemyData[unit]["hp"]
	hp = maxHp
	baseSpeed = GameData.enemyData[unit]["speed"]
	speed = baseSpeed
