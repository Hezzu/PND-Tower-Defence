extends "res://Scenes/Enemies/EnemyMgr.gd"

func _ready():
	unit = "greenminiboss"
	maxHp = GameData.enemyData[unit]["hp"]
	hp = maxHp
	baseSpeed = GameData.enemyData[unit]["speed"]
	speed = baseSpeed
