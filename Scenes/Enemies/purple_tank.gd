extends "res://Scenes/Enemies/EnemyMgr.gd"


func _ready():
	unit = "purpletank"
	maxHp = GameData.enemyData[unit]["hp"]
	hp = maxHp
	armor = GameData.enemyData[unit]["armor"]
	baseSpeed = GameData.enemyData[unit]["speed"]
	speed = baseSpeed
