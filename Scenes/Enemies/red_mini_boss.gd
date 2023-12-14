extends "res://Scenes/Enemies/EnemyMgr.gd"

func _ready():
	unit = "redminiboss"
	maxHp = GameData.enemyData[unit]["hp"]
	hp = maxHp
	baseSpeed = GameData.enemyData[unit]["speed"]
	speed = baseSpeed
	hpbar.set_max(hp)
	hpbar.set_value(hp)
