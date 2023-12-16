extends Panel
var unit
var hp
var speed
var baseDmg

func _ready():
	unit = $MarginContainer/VBoxContainer/Unit
	hp = $MarginContainer/VBoxContainer/Hp
	speed = $MarginContainer/VBoxContainer/Speed
	baseDmg = $MarginContainer/VBoxContainer/BaseDmg

func fillInfo(enemy):
	unit.text = enemy.unit
	hp.text = "HP: " + str(round(enemy.maxHp)) + "/" + str(round(enemy.hp))
	speed.text = "Speed: " + str(enemy.speed)
	baseDmg.text = "Damge to Base: " + str(GameData.enemyData[enemy.unit]["base_dmg"])
