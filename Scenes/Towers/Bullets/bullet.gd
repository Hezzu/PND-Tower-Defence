extends "res://Scenes/Towers/Bullets/bulletMgr.gd"

func _ready():
	type = "bullet"
	hitSound = $hitSound
	hitEffect = $hitEffect
	speed = GameData.bulletData[type]["speed"]
	dmgMod = GameData.bulletData[type]["dmgInc"]
