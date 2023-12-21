extends MarginContainer
var unit
var hp
var armor
var speed
var baseDmg

func _ready():
	unit = $MarginContainer/VBoxContainer/Unit
	hp = $MarginContainer/VBoxContainer/Hp
	armor = $MarginContainer/VBoxContainer/Armor
	speed = $MarginContainer/VBoxContainer/Speed

func fillInfo(enemy):
	unit.text = enemy.unit
	hp.text = "HP: " + str(ceil(enemy.hp)) + "/" + str(ceil(enemy.maxHp))
	if enemy.armor < 1:
		armor.visible = true
		armor.text = "Armor: " + str((1.0 - enemy.armor) * 100) + "%"
	speed.text = "Speed: " + str(round(enemy.speed))
