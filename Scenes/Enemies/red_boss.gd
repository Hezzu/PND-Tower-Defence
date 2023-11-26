extends "res://Scenes/Enemies/EnemyMgr.gd"

func _ready():
	unit = "redboss"
	hp = GameData.enemyData[unit]["hp"]
	speed = GameData.enemyData[unit]["speed"]
	hpbar.set_max(hp)
	hpbar.set_value(hp)
