extends "res://Scenes/Towers/Bullets/bulletMgr.gd"

func _ready():
	type = "bullet"
	speed = GameData.bulletData[type]["speed"]
